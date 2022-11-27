function ring = find_ring(each_cell, r1, r2)    
    surf = find_surf(each_cell);
    dis_mat = bwdist(surf);
    ring = (dis_mat>=r1 & dis_mat < r2) & each_cell;
end