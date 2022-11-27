function         plotNode3D(MLWL, cellGraph, mode)
        sz = size(MLWL); 
      c = [ 'm', 'c','k','y',];
%       figure,
      if ~isempty(cellGraph)
          for i = 1:size(cellGraph,1)
              Node = cellGraph{i,4};
            for j = 1:length(Node) 
                voxel = find(MLWL==Node(j,1));
                [x,y,z] = ind2sub(sz, voxel);
                % mode0:每个节点颜色都不同
                if mode == 0
                    scatter3(x,y,z,'filled','MarkerFaceColor',rand(1,3));
                % mode1:每个细胞颜色不同
                elseif mode == 1
                    scatter3(x,y,z,'filled','MarkerFaceColor',c(i));
                
                elseif mode == 2
                    scatter3(x,y,z,'filled','MarkerFaceColor',c(1));

                end
                
                hold on
            end
          end
      else
          Node = double(max(MLWL(:)));
        for j = 1:Node
                voxel = find(MLWL==j);
                [x,y,z] = ind2sub(sz, voxel);
                scatter3(x,y,z,'filled','MarkerFaceColor',rand(1,3));
                hold on
        end
      end
%       axis([0 200 0 200 0 200])
end