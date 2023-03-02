function [cell_isolate, cell_packed] = crop_merge(cell_isolate, cell_packed, nucle_segment, single_volume,link_volume_rules, vole_thr, mode)

[multi_cell_labeln, n_cc] = bwlabeln(logical(cell_packed));
stack_size = size(cell_isolate);
bboxes = convert_bbox(table2array(regionprops3(multi_cell_labeln, 'BoundingBox')), stack_size, 0);

n_multi = 0;
n_one = max(cell_isolate(:));

cell_packed=zeros(stack_size);
fprintf(strcat("first round merging using the ",mode,"\n"));
for i = 1:n_cc
    
    fprintf(strcat("instance segment for %d connected component \n"), i);
    
    tmp_cell_bbox = bbox2cell((multi_cell_labeln==i), bboxes(i,:));
    tmp_nucle_bbox = bbox2cell(nucle_segment, bboxes(i,:));
    
    tmp_nucle_n = bwlabeln(tmp_nucle_bbox & tmp_cell_bbox);
    
    % crop once
    [MLWL, T, E, D, area_block] = crop_component(tmp_cell_bbox, vole_thr);
    
    if isempty(T)
        n_one = n_one+1;
        cell_isolate(logical(chunk2stack(MLWL, bboxes(i,:), stack_size)))=n_one;
    else
        % first round merge
        [cell_mat, area_cell]= first_round_merge(tmp_nucle_n, MLWL, T, E, D, area_block,mode);
        
        if max(cell_mat(:)) > 1
            
            cell_mat = second_round_merge(cell_mat, area_cell, single_volume, link_volume_rules);
            if max(cell_mat(:)) > 1
                for j=1:max(cell_mat(:))
                    n_multi = n_multi + 1;
                    cell_packed(chunk2stack((cell_mat==j), bboxes(i,:), stack_size)==1)=n_multi;
                end
            else
                n_one = n_one+1;
                cell_isolate(chunk2stack(cell_mat==1, bboxes(i,:), stack_size)==1)=n_one;
            end
        else
            n_one = n_one+1;
            cell_isolate(chunk2stack(cell_mat==1, bboxes(i,:), stack_size)==1)=n_one;
        end
    end
end
end
