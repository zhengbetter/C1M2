function [U, Uind] = wsline2nighborhood(ML, MS)
%% check for all voxel on the watershed-line, which cluster they are bordering with
    %--- get indices and subscripts of each watershed-line voxel
    Uind = find(MS==1);
    [x,y,z] = ind2sub(size(MS), Uind);
    %--- define a box around each voxel
    x = [x-1, x+1];
    y = [y-1, y+1];
    z = [z-1, z+1];
    %--- crop the box at the lower border of the matrix
    x(x(:,1)<1, 1) = 1;
    y(y(:,1)<1, 1) = 1;
    z(z(:,1)<1, 1) = 1;
    %--- crop the box at the upper border of the matrix
    x(x(:,2)>size(MS,1), 2) = size(MS,1);
    y(y(:,2)>size(MS,2), 2) = size(MS,2);
    z(z(:,2)>size(MS,3), 2) = size(MS,3);
    %--- get the neighbors for each voxel on the watershed line
    U = cell(length(Uind),1);
    for i=1:length(Uind)
        temp = unique(ML(x(i,1):x(i,2), y(i,1):y(i,2), z(i,1):z(i,2)));
        U{i} = temp(2:end); %--- remove the "0" which is always present as the value of the watershed line voxel itself
    end
end