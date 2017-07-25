function processSubcorticalRegionalization(subjectList,dataDir)

fid = fopen(subjectList,'r');
temp = textscan(fid,'%s\n');
subjects = temp{1};
disp(subjects)

hemis = {'Left','Right'};

for s = 1:length(subjects)

    currSubj = subjects{s};
    disp(currSubj)
    fprintf('Processing subjects %s.\n',currSubj);
    subjDir = sprintf('%s%s/ProbTrackX2/',dataDir,currSubj);
    
    for h = 1:length(hemis)
        hemi = hemis{h};
        fprintf('Processing %s hemisphere.\n',hemi);

        inMapH5 = sprintf('%s%s.VoxelMappings.h5',subjDir,hemi);
        inFDT2 = sprintf('%s%s/fdt_matrix2.dot',subjDir,hemi);
        
        if exist(inMapH5,'file') && exist(inFDT2,'file')

            fprintf('Generating subcortical voxel mappings.\n'); 
            inMappings = mapLabelToIndices(inMapH5);
            fprintf('Computing subcortical regionalization.\n');
            subCortReg = regionalizeTractography(inMappings,inFDT2);

            hemiOut = sprintf('%s%s/%s.SubcorticalRegionalization.mat',subjDir,hemi,hemi);
            save(hemiOut,'subCortReg','-v7.3');
        end
    end
end
end
        
    