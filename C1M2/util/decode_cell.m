function all_cells = decode_cell(cell_mat,channel_num)
    all_cells = false([size(cell_mat), channel_num]);

    for i=1:max(cell_mat(:))
        each_cell = cell_mat==i;
        stack_ind = mod(i-1, channel_num)+1;
        
        all_cells(:,:,:, stack_ind) = all_cells(:, :, :, stack_ind) | each_cell;
    end
%     all_cells = all_cells;
end