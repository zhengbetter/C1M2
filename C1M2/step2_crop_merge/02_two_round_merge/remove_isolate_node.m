function [GC, MLWL, T] = remove_isolate_node(G, MLWL, T)

    edges = reshape(G.Edges.EndNodes,[],1);
    ind = ismember(1:size(G.Nodes,1), edges);
    rm_id = find(ind==0);
    nodeIDs = find(ind);
    GC = subgraph(G, nodeIDs);
    for i=1:size(rm_id,2)
        MLWL(MLWL==rm_id(i))=0;
    end
    MLWL = remove_gap(MLWL);
    T = T(nodeIDs,:);

end