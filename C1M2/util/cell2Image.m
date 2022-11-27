function sort_cells = cell2Image(sort_cells, cells_c, cell_class, count_select, newSize)
            
    img = sort_cells{cell_class+1,1};
    [~,y,~] = size(img);
    y = y / 128;
    
    cell_x = floor((count_select(cell_class+1)-1)/y);
    cell_y = mod((count_select(cell_class+1)-1), y);
    
    x_s = cell_x*newSize(1,1)+1;
    x_e = (cell_x+1)*newSize(1,1);
    y_s = cell_y*newSize(1,2)+1;
    y_e = (cell_y+1)*newSize(1,2);
    
    for i = 1:size(cells_c,3)
        img(x_s:x_e, y_s:y_e,i) = cells_c(:,:,i);
    end
    
    sort_cells{cell_class+1,1} = img;
end