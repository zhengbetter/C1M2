function label_old_new = label_new_interlaced_tuple(merge, ML, node_thr)

    %--- check whether nodes to be merged overlap and merge these groups
    [merge, lm] = merge_node(merge, ML,node_thr);

    %--- create assignment table "labelOldNew" for merging operation
    label_old_new = nan(sum(lm)-length(lm),1);
    k=0;
    for i=1:length(merge)
        ll = length(merge{i})-1;
        label_old_new(k+1:k+ll,1) = merge{i}(2:end);
        label_old_new(k+1:k+ll,2) = merge{i}(1);
        k = k+ll;
    end
end