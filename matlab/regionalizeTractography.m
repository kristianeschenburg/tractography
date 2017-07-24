function [subcortreg] = regionalizeTractography(labelMaps,fdt)

regions = labelMaps(:,1);

x = load(fdt);
m = spconvert(x);

subcortreg = zeros(size(m,1),length(regions));

for k = 1:length(regions)
    
    tempSum = sum(m(:,labelMaps{k,2}),2);
    subcortreg(:,k) = tempSum;
    
end