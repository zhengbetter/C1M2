function each_cell = GCMLWLNodes2Mask(GCMLWLNodes, MLWL)
    
    %Get the mask of single cell instance segmentation
    each_cell = uint8(zeros(size(MLWL))); 
    for j = 1:size(GCMLWLNodes,1)
        each_cell(MLWL == GCMLWLNodes(j,1)) = 1;
    end

    w = ones(3,3,3);
    each_cell = imfilter(each_cell, w, 'same'); 
    each_cell(each_cell > 0.1) = 1; 
end
