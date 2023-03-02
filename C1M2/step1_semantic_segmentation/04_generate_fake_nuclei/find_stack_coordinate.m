function coor_nucle = find_stack_coordinate(nucle_r)

    center = round(table2array(regionprops3(nucle_r,'Centroid')));
    center2 = center;
    center(:,1)=center2(:,2);
    center(:,2)=center2(:,1);
    
    stackSize = size(nucle_r);
    z=center(:,3);
    z(z>stackSize(3))=stackSize(3);
    z(z<=0) = 1;
    
    y=center(:,2);
    y(y>stackSize(2))=stackSize(2);
    y(y<=0) = 1;
    
    x=center(:,1);
    x(x>stackSize(1))=stackSize(1);
    x(x<=0)=1;
    center = [x,y,z];
    % 
    ind = sub2ind(size(nucle_r), center(:,1), center(:,2), center(:,3));
    coor_nucle = uint8(false(size(nucle_r)));
    coor_nucle(ind)=1;

end