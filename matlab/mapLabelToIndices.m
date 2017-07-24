% Generates the dictionary mapping labels to vertex indices
% 
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