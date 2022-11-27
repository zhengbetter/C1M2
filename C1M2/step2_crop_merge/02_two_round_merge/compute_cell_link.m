function cell_link = compute_cell_link(cell_mat)
    w = zeros(3,3,3);
    w = w-1;
    w(2,2,2)=26;
    
    MS = logical(imfilter(cell_mat, w));
    
    [U, Uind] = wsline2nighborhood(cell_mat, MS);
    Ul = cellfun(@length,U);
    [U, ~, ~] = remove_voxel_01(U,Ul, Uind);

    neighbors = compute_neighbors(U,max(cell_mat(:)));
    ind = find(neighbors);
    [x,y] = ind2sub(size(neighbors), ind);
    cell_link = zeros(size(x,1),3);
    cell_link(:,1:2) = sort([x,y],2);
    cell_link(:,3) = neighbors(ind);
    cell_link = unique(cell_link, 'rows');

end
