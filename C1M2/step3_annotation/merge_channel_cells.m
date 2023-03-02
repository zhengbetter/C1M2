function [cell_isolate, cell_packed] = merge_channel_cells(red_isolate, red_packed, red_semantic, green_isolate, green_packed)

    cell_isolate = red_isolate;
    for i= 1:max(green_isolate(:))
        tmp_green = green_isolate==i;
        ratio = sum(tmp_green & red_semantic , 'all')/sum(tmp_green(:));
        if ratio < 0.2
            cell_isolate(tmp_green) = max(cell_isolate(:))+1;
        end
    end
    
    cell_packed = red_packed;
    for i= 1:max(green_packed(:))
        tmp_green = green_packed==i;
        ratio = sum(tmp_green .* red_semantic, 'all')/sum(tmp_green(:));
        if ratio < 0.2
            cell_packed(tmp_green) = max(cell_packed(:))+1;
        end
    end

end