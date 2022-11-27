function count = node2Voxel(ML,node)
    count = 0;
    for i = 1:size(node,1)
        count = count+ sum(ML==node(i), 'all');
    end
end