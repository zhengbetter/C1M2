function nucle_r = round_nucle(nucle, pixdim)

    center = round(table2array(regionprops3(nucle,'Centroid')));
    center2 = center;
    center(:,1)=center2(:,2);
    center(:,2)=center2(:,1);
    
    stackSize = size(nucle);
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
    
    ind = sub2ind(size(nucle), center(:,1), center(:,2), center(:,3));

    nucle_r = uint8(false(size(nucle)));
    nucle_r(ind)=1;
    nucle_r = imdilate(nucle_r, defineCenterStructure(pixdim, 1));
end