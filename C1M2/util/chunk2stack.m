function stack = chunk2stack(cell_mat, bbox, stackSize)
    
    stack = uint8(zeros(stackSize));
    minTotal = bbox(1:3);
    maxTotal = bbox(4:6);
    
    stack(minTotal(1):maxTotal(1), minTotal(2):maxTotal(2), minTotal(3):maxTotal(3))= cell_mat;
end