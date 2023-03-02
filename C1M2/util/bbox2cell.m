function cell_3D = bbox2cell(img, bbox)
    
    minTotal = bbox(1:3);
    maxTotal = bbox(4:6);
    
    cell_3D = img(minTotal(1):maxTotal(1), minTotal(2):maxTotal(2), minTotal(3):maxTotal(3));
end    
