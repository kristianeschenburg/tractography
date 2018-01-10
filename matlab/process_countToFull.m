addpath('/mnt/parcellator/parcellation/Matlab/SpectralMatching/Requirements/');

homeDirectory = char('/mnt/parcellator/parcellation/HCP/Connectome_4/')
subjectList = sprintf('%sSubjectList.txt',homeDirectory);


fid = fopen(subjectList,'r');
temp = textscan(fid,'%s\n');
subjects = temp{1};

hemispheres = {'Left','Right'};


for s = 1:length(subjects)

	S = subjects{s};
	subjectDirectory = sprintf('%s%s/',homeDirectory,S);

	for h = 1:2

		H = hemispheres{h};

		if strcmp(H,'Left')
			hemi = 'L'
		else
			hemi = 'R'
		end

		hemisphereDirectory = sprintf('%sProbTrackX2/%s/',subjectDirectory,H);

		for l = 1:2

			tempDot = sprintf('%sfdt_matrix%i.dot',hemisphereDirectory,l);
			outDot = sprintf('%sfdt_matrix%i.mat',hemisphereDirectory,l);

			if ~exist(outDot,'file')
				if exist(tempDot,'file')
					counts = countsToFull(tempDot);
					save(outDot,'counts','-v7.3');
				end
			end
		end
	end
end