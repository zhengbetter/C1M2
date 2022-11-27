function [cell_mat, cell_link] = first_round_merge(nucleusL, MLWL, T, E, D, neighbors, mode)

    if max(MLWL(:))>1
        [G, ML] = decode_graph(MLWL,T,E,D,neighbors);
        %
        [SNV, ~, nucleusL] = overlap_soma_node(nucleusL, ML);
        [SNV,~, ~] = one_node_multiple_soma(SNV, nucleusL);
        seedNodes = SNV(:,2);
        
        separate_path=[];
        separate_weight = [];
        if size(seedNodes,1) > 1       
            % verify the directly packed paths between each pair of seed nodes
            GS = G;
            while true
                dPaths = verifyLink(GS,seedNodes); 
                if ~isempty(dPaths)
                    [GS, tmp_separatePath, tmp_separateWeight] = separate_graph(GS, dPaths, mode);
                    separate_path = [separate_path;tmp_separatePath];
                    separate_weight = [separate_weight;tmp_separateWeight];
                else
                    break;
                end
            end
            
            merged_graphs = split_graph(GS, seedNodes);
        else
            merged_graphs = split_graph(G, seedNodes);
        end

    [cell_mat, cell_link] = graph2mat(merged_graphs, ML);
    else
        cell_mat = MLWL;
        cell_link=[];
    end
end
