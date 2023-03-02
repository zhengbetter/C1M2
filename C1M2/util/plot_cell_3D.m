function  plot_cell_3D(MLWL)

    sz = size(MLWL); 
  
    Node = double(max(MLWL(:)));
    figure,
    for j = 1:Node
            voxel = find(MLWL==j);
            [x,y,z] = ind2sub(sz, voxel);
            scatter3(x,y,z,'filled','MarkerFaceColor',rand(1,3));
            hold on
    end


end