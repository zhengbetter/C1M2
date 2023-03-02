function bbox = convert_bbox(bbox2, stackSize, offset)


    bbox2(:, 4:6)=bbox2(:,1:3)+bbox2(:, 4:6);
    bbox2 = round(bbox2);
    
    bbox = bbox2;
    bbox(:,1)=bbox2(:,2);
    bbox(:,2) = bbox2(:,1);
    bbox(:,4) = bbox2(:,5);
    bbox(:,5) = bbox2(:,4);
    
    minTotal = bbox(:,1:3);
    maxTotal = bbox(:,4:6);
    minTotal = minTotal - offset;
    maxTotal = maxTotal + offset;
    
    
    minTotal(minTotal<=0) = 1;
    z=maxTotal(:,3);
    z(z>stackSize(3))=stackSize(3);

    y=maxTotal(:,2);
    y(y>stackSize(2))=stackSize(2);

    x=maxTotal(:,1);
    x(x>stackSize(1))=stackSize(1);
    maxTotal = [x,y,z];

    bbox = [minTotal,maxTotal];
    
end