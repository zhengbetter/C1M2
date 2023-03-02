function bboxes = align_bbox_cell(bboxes, cell_images)
    for i=1:size(bboxes,1)
        bboxes(i,4:6) = bboxes(i,1:3)+size(cell_images{i,1})-1;
    end
end