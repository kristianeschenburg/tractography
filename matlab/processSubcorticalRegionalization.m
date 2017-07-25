function processSubcorticalRegionalization(subjectList,dataDir)

fid = fopen(subjectList,'r');
temp = textscan(fid,'%s\n');
subjects = temp{1};

hemis = ['Left','Right'];

for s = 1:length(subjects)

    currSubj = subjects(s);
    sprintf('Processing subjects %s.',currSubj);
    subjDir = sprintf('%s%s/ProbTrackX2/',dataDir,currSubj);
    
    for h = 1:length(hemis)
        hemi = hemis(h);
        sprintf('Processing %s hemisphere.',hemi);

        inMapH5 = sprintf('%s%s/%s.VoxelMappings.h5',subjDir,hemi,hemi);
        inFDT2 = sprintf('%s%s/fdt_matrix2.dot',subjDir,hemi,hemi);
        
        if exist(inMapH5,'file') && exist(inFDT2,'file')

            sprintf('Generating subcortical voxel mappings.'); 
            inMappings = mapLabelToIndices(inMapH5);
            sprintf('Computing subcortical regionalization.');
            subCortReg = regionalizeTractography(inMappings,inFDT2);

            hemiOut = sprintf('%s%s/%s.SubcorticalRegionalization.mat',subjDir,hemi,hemi);
            save(hemiOut,'subCortReg','-v7.3');
        end
    end
end
end
        
    