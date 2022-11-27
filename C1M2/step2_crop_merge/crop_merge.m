function [cell_one, cell_multi] = crop_merge(cell_one, cell_multi, nucle_segment, single_volume,link_volume_rules, vole_thr, mode)

[multi_cell_labeln, n_cc] = bwlabeln(logical(cell_multi));
stack_size = size(cell_one);
bboxes = convert_bbox(table2array(regionprops3(multi_cell_labeln, 'BoundingBox')), stack_size, 0);

n_multi = 0;
n_one = max(cell_one(:));

cell_multi=zeros(stack_size);
fprintf(strcat("first round merging using the ",mode,"\n"));
for i = 1:n_cc
    
    fprintf(strcat("instance segment for %d connected component \n"), i);
    
    tmp_cell_bbox = bbox2cell((multi_cell_labeln==i), bboxes(i,:));
    tmp_nucle_bbox = bbox2cell(nucle_segment, bboxes(i,:));
    
    tmp_nucle_n = bwlabeln(tmp_nucle_bbox & tmp_cell_bbox);
    
    % crop once
    [MLWL, T, E, D, neighbors] = crop_component(tmp_cell_bbox, vole_thr);
    
    if isempty(T)
        n_one = n_one+1;
        cell_one(logical(chunk2stack(MLWL, bboxes(i,:), stack_size)))=n_one;
    else
        % first round merge
        [cell_mat, cell_link]= first_round_merge(tmp_nucle_n, MLWL, T, E, D, neighbors,mode);
        
        if max(cell_mat(:)) > 1
            
            cell_mat = second_round_merge(cell_mat, cell_link, single_volume, link_volume_rules);
            if max(cell_mat(:)) > 1
                for j=1:max(cell_mat(:))
                    n_multi = n_multi + 1;
                    cell_multi(chunk2stack((cell_mat==j), bboxes(i,:), stack_size)==1)=n_multi;
                end
            else
                n_one = n_one+1;
                cell_one(chunk2stack(cell_mat==1, bboxes(i,:), stack_size)==1)=n_one;
            end
        else
            n_one = n_one+1;
            cell_one(chunk2stack(cell_mat==1, bboxes(i,:), stack_size)==1)=n_one;
        end
    end
end
end
