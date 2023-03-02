function [G, separate_edge, min_w] = separte_connect_path(G, connectPaths)

    pathL = cellfun(@length,connectPaths);
    [~, I] =sort(pathL, 'descend');
    edge = table2array(G.Edges);
    % select a edge
    [sN, eN] = array4edge(cell2mat(connectPaths(I(1))));
    % obtaind the edge weight
    labelWeight = edge2weight(sN,eN, edge, G.Edges.Neighbors);
    % find the minimum weight
    [min_w,idx] = min(labelWeight);
    separate_edge = [sN(idx), eN(idx)];
    G = rmedge(G, sN(idx), eN(idx));

end