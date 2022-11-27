function [G, separatePath, separateWeight] = separate_two_seednode_graph(G, seedNodes)

    separatePath = {};
    separateWeight = [];
    i = 1;
    while true 

        connectPaths = allpaths(G, seedNodes(1), seedNodes(2), "MaxNumPaths",5, "MaxPathLength",20); 

        if  ~isempty(connectPaths) 
            
            [G, separate_edge, min_w] = separte_connect_path(G, connectPaths);
            separatePath{i,1} = separate_edge; 
            separateWeight = [separateWeight;min_w];
            i = i+1;
        else
            short_path = shortestpath(G, seedNodes(1), seedNodes(2), 'Method', 'unweighted');

            if  ~isempty(short_path) 
                short_path = mat2cell(short_path, 1);
                [G, separate_edge, min_w] = separte_connect_path(G, short_path);
                separatePath{i,1} = separate_edge; 
                separateWeight = [separateWeight;min_w];
                i = i+1;
            else
                break;
            end
        end
    end
end