function surf = find_surf(each_cell)
    d1 = bwdist(each_cell);
%     d2 = bwdist(~each_cell);
%     bwbd = (d1==d2+1);
    surf_1 = d1==1;
    surf = (bwdist(surf_1)==1) & each_cell;
    
end