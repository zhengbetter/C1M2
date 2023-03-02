function [cell_non, cell_one, cell_multi] = filter_connected_component(nucle_semantic, cell_semantic)
    stackSize = size(cell_semantic);
    [cell_labeln, n_cc] = bwlabeln(cell_semantic);
    
    bboxes = convert_bbox(table2array(regionprops3(cell_labeln, 'BoundingBox')), stackSize, 0);
    
    cell_non = zeros(stackSize);
    cell_one = zeros(stackSize);
    cell_multi = zeros(stackSize);
    
    n_cell = 0;
    fprintf('total connected components is %d\n', n_cc);
    for i =1:n_cc
        
        tmp_cell_bbox = bbox2cell((cell_labeln==i), bboxes(i,:));    
        tmp_nucle_bbox = bbox2cell(nucle_semantic, bboxes(i,:));    
        
        [~, n_nucle] = bwlabeln(tmp_nucle_bbox & tmp_cell_bbox);
    
        if n_nucle==0
            n_cell = n_cell + 1;
            cell_non(chunk2stack(tmp_cell_bbox, bboxes(i,:), stackSize)==1)=n_cell;
    
        elseif n_nucle==1
            n_cell = n_cell + 1;
            cell_one(chunk2stack(tmp_cell_bbox, bboxes(i,:), stackSize)==1)=n_cell;
            
        elseif n_nucle>1
            n_cell = n_cell+1;
            cell_multi(chunk2stack(tmp_cell_bbox, bboxes(i,:), stackSize)==1)=n_cell;
    
        end
    end
    
    cell_one = remove_gap(cell_one);
    cell_multi = remove_gap(cell_multi);
    cell_non = remove_gap(cell_non);
    fprintf('The number of connected components no nucles is %d\n', max(cell_non(:)));    
    fprintf('The number of connected components have 1 nucles is %d\n', max(cell_one(:)));    
    fprintf('The number of connected components have multi nucles is %d\n', max(cell_multi(:)));    
end