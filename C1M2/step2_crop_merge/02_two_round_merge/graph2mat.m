function [cell_mat, cell_link] = graph2mat(cellGraph, MLWL)
    
    cell_mat = zeros(size(MLWL));
    
    if size(cellGraph,1) > 1
        for i = 1:size(cellGraph,1)
            gc_node = cellGraph{i,4};
            cell_mat(logical(GCMLWLNodes2Mask(gc_node, MLWL))) = i;
        end      
        cell_link = compute_cell_link(cell_mat);
    else
        gc_node = cellGraph{1,4};
        cell_mat(logical(GCMLWLNodes2Mask(gc_node, MLWL))) = 1;
        cell_link = [];
    end
    
end
