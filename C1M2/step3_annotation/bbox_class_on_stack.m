function bboxes_label = bbox_class_on_stack(bboxes_label, coordinate, cell_class)
    if cell_class >= 0
        minTotal = coordinate(1:3);
        maxTotal = coordinate(4:6);
        [startPoints, endPoints] = genTwelveLine(minTotal, maxTotal);
        
        bbox_tmp = bboxes_label{cell_class+1,1};
        bbox_tmp = setEdge(startPoints, endPoints, bbox_tmp, 2);
        bboxes_label{cell_class+1,1} = bbox_tmp;
    end
end