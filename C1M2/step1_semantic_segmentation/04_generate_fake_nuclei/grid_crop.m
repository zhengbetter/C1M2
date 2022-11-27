function cell_semantic = grid_crop(cell_semantic, vol_thr, interval)
    
    [cell_mat, ~] = bwlabeln(cell_semantic);
    stackSize = size(cell_mat);
    bboxes = convert_bbox(table2array(regionprops3(cell_mat, 'BoundingBox')), stackSize,0);
    volume = table2array(regionprops3(cell_mat, 'Volume'));
    inds = find(volume > vol_thr);

    for i=1:size(inds)
        
        ind = inds(i);
        tmp_cell = cell_mat==ind;
    
        cell_semantic(tmp_cell) = 0;
        tmp_cell = bbox2cell(tmp_cell, bboxes(ind,:));

        tmp_cell(1:interval:end,:,:)=0;
        tmp_cell(:,1:interval:end, :) = 0;
        cell_semantic = cell_semantic | chunk2stack(tmp_cell, bboxes(ind,:),stackSize);
    end
end