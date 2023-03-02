function [G, ML] = decode_graph(MLWL,T,E,D,neighbors)

    WLidx = max(MLWL(:));
    ML = MLWL;
    ML(ML==WLidx) = 0;
    MLn = WLidx-1; 

    T.Label = (1:height(T))';

    G = graph(E(:,1), E(:,2), D, MLn);

    edge = table2array(G.Edges);
    weight_neighbor = zeros(size(edge,1),1);
    for i = 1:size(edge,1)
        weight_neighbor(i) = neighbors(edge(i,1), edge(i,2));
    end
    G.Edges.Neighbors = weight_neighbor;

    voxel_array = zeros(MLn,1);
    for i = 1:MLn
         a = (MLWL == i);
         voxel_array(i) = sum(a(:));
    end
    
    weight_voxel = zeros(size(edge,1),2);
    for i = 1:size(edge,1)
        weight_voxel(i,1) = voxel_array(edge(i,1));
        weight_voxel(i,2) = voxel_array(edge(i,2));
    end
    G.Edges.VoxelNumbers = weight_voxel;

    [G, ML,~] = remove_isolate_node(G, ML, T);
end