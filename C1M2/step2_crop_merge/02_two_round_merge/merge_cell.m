function [cell_volume, cell_link, merged] = merge_cell(cell_link, cell_volume, t1_link, t2_link, vol_thr)
    unmerged=[];
    merged = [];
    while true
        row_id = find(t1_link <= cell_link(:,3) & cell_link(:,3)<t2_link);
        if ~isempty(row_id)    
            two_cell = cell_link(row_id(1),1:2);
            cell_ind = find(cell_volume(two_cell)< vol_thr); 
            
            if ~isempty(cell_ind)
                deter_id = two_cell(cell_ind(1));
                link_row = find(cell_link(:,2)==deter_id | cell_link(:,1)==deter_id);

                if size(link_row,1)>1
%                     link_row(cell_volume(link_row)<0.3)=[];
                    [~, mer_id] = max(cell_link(link_row,3));
                    mer_id = link_row(mer_id);
                else
                    mer_id = link_row;
                end

                merged = [merged;cell_link(mer_id,1:2)];

                s_id = cell_link(mer_id,1);
                e_id = cell_link(mer_id,2);
                cell_volume(e_id)=cell_volume(s_id)+cell_volume(e_id);
                cell_volume(s_id) = 0;
                cell_link(cell_link==s_id)=e_id;
                cell_link(mer_id,:)=[];
                
                [path_uni, ~, ic] = unique(cell_link(:,1:2), "rows");
                if size(path_uni,1) < size(cell_link,1)
                    for i=1:size(path_uni,1)
                        path_uni(i,3)= sum(cell_link((ic==i),3),'all');
                    end
                    path_uni(path_uni(:,1)==path_uni(:,2),:)=[];
                    cell_link = path_uni;
                end

            
            else
                unmerged = [unmerged; cell_link(row_id(1), :)];
                cell_link(row_id(1), :)=[];
            end
            
        else 
            break;
        end
    end
    cell_link = [cell_link;unmerged];


end