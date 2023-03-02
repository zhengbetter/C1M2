function [merge, lm] = merge_node(merge,ML, node_thr)
    
    merged_node = 0;
    for i=1:length(merge)    
        if any(~ismember(merge{i}, merged_node))
            merge_new_i = merge{i}(~ismember(merge{i}, merged_node));
            voxel_count = node2Voxel(ML,merge_new_i);
            if voxel_count < node_thr 
                for j=i+1:length(merge)
                    if any(ismember(merge{i}(:), merge{j}(:)))
                        merge_new_j = merge{j}(~ismember(merge{j}, merged_node));
                        merge{j} = unique(vertcat(merge_new_i, merge_new_j));
                        merge{i} = [];
                        break
                    end
                end
            else
                merged_node = [merged_node;merge{i}];
            end
        else
            merge{i}=[];
        end
    end
    
    %--- remove cells from merge which ar now empty
    lm = cellfun(@length, merge);
    merge(lm==0) = [];
    lm(lm==0) = [];
end