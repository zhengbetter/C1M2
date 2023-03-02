function cell_mat = second_round_merge(cell_mat, cell_link,cell_t5, link_volume_rules)
    
    cell_volume_b = table2array(regionprops3(cell_mat, 'Volume'))/cell_t5;
    merged = [];
%     figure,plot_cell_3D(cell_mat) % visualizing merged results 
    for i=1:size(link_volume_rules,1)
        i_rules = link_volume_rules(i,:);
        [cell_volume_b, cell_link, tmp_merged] = merge_cell(cell_link, ...
                        cell_volume_b, i_rules(1), i_rules(2), i_rules(3));
        merged = [merged; tmp_merged];
    end
    
    for i=1:size(merged,1)
        cell_mat(cell_mat==merged(i,1))=merged(i,2);
        merged(merged==merged(i,1))=merged(i,2);
    end
    cell_mat = remove_gap(cell_mat);
%    figure,plot_cell_3D(cell_mat) % directly visualizing merged results 
%    close all
end