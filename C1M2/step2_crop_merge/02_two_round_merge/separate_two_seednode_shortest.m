function [G, separatePath, separateWeight] = separate_two_seednode_shortest(G, seedNodes)

    separatePath = {};
    separateWeight = [];
    i = 1;
    while true 
        short_path = shortestpath(G, seedNodes(1), seedNodes(2), 'Method', 'unweighted');
        if  ~isempty(short_path) 
            
            edge = table2array(G.Edges);
            % select a edge
            [sN, eN] = array4edge(short_path);
            % obtaind the edge weight 
            labelWeight = edge2weight(sN,eN, edge, G.Edges.Neighbors);
            % find the minimum weight
            [min_w,idx] = min(labelWeight);
            separate_edge = [sN(idx), eN(idx)];
            G = rmedge(G, sN(idx), eN(idx));

            separatePath{i,1} = separate_edge; 
            separateWeight = [separateWeight;min_w];
            i = i+1;
        else
            break;
        end
    end
end