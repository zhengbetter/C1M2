function bboxes_label = annotate_bbox(cell_class, bboxes, stack_size)
    
    n_class = max(cell_class)+1;
    bboxes_label = cell(n_class,1);
    for i=1:n_class
        bboxes_label{i,1} = uint8(zeros(stack_size));
    end
    for i = 1:size(bboxes, 1)
        bboxes_label = bbox_class_on_stack(bboxes_label, bboxes(i,:), cell_class(i));
    end
end