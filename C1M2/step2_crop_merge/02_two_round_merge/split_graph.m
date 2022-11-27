function cellGraph = split_graph(G, seed_node)
    
    cellGraph = cell(size(seed_node,1),4);

    for i=1:size(seed_node,1)
        cellNode = dfsearch(G, seed_node(i));
        GS = subgraph(G, cellNode); 
               
        cellGraph{i,4} = cellNode; 
        cellGraph{i,3} = seed_node(i);
        cellGraph{i,2} = find(cellNode==seed_node(i));
        cellGraph{i,1} = GS;

    end  

end
