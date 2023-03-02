function D = compute_node_distance(E, T)
    %% calculate the distance between nodes, being connected by edges
    D = zeros(size(E,1),1);
    for i=1:size(E,1)
        D(i) = sum((T.Centroid(E(i,1),:) - T.Centroid(E(i,2),:)).^2)^.5;
    end
end