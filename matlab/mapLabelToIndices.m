% Generates the dictionary mapping labels to vertex indices
% Takes .h5 output of parcellearning/tractographyProcessing.py
% and converts it to a matlab cell structure.

% We preferentially use Matlab here for the tractography processing
% due to difficulty in loading the fdt_matrix$.dot files in Python.
function [dict] = mapLabelToIndices(hemisphereCoords)

rois = h5readatt(hemisphereCoords,'/','regions');
labels = zeros(length(rois));

for r = 1:length(rois)
    labels(r) = h5readatt(hemisphereCoords,'/regionValues',rois{r,1});
end

dict = cell(length(rois),2);

for k = 1:length(labels)
    
    currentLabel = labels(k);
    loc = sprintf('/%i',currentLabel);
    tempData = h5read(hemisphereCoords,loc);
    dict(k,:) = [rois{k,1},{tempData}];
    
end