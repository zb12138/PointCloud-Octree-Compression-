clear
load('occupancyShow.mat');
Lmax = size(Octree,2);
pointNum = size(point,1);
pcolor = zeros(pointNum,Lmax);
for level = 1:Lmax
    ptInOccupancy = arrayfun(@(S)S.childPoint,Octree(level).node,'UniformOutput',false)';
    Occupancy = cell2mat(arrayfun(@(S)S.occupancyCode,Octree(level).node,'UniformOutput',false)');
    Occupancy = bin2dec(num2str(Occupancy));
    for i=1:length(ptInOccupancy)
        pIo = ptInOccupancy(i);
        pcolor(cell2mat(pIo{:}),level)=Occupancy(i);
    end
end

for i = 1:Lmax
subplot(2,4,i);
pcshow(point,pcolor(:,i));
end