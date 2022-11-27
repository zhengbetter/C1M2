function [MLWL, T, E, D, neighbors] = merge_water_shed_v2(img_BW, node_thr, pixdim)

    %% create mask for the whole cells
    M = logical(img_BW); 
    %% watershed segment
    conn = 18;
    [ML, MS, ~] = watershed_mmqt(M, conn);

    %% check for all voxel on the watershed-line, which cluster they are bordering with
    [U, Uind] = wsline2nighborhood(ML, MS);
    Ul = cellfun(@length,U);
    [U, Ul, Uind] = remove01Voxel(U,Ul, Uind);

    UN = findUN(U, Ul);
%%
    UN = isIncludeTuple(UN);

    merge = findInterlacedTuple(UN);

    while  true
        
        labelOldNew = newLabel4InterlacedTuple(merge, ML, node_thr); 
    
        [U2, ~, ~, UN2, ML2,MS2] = updateU_UN_ML_MS(U, Uind, UN,ML,MS,labelOldNew);
        
        [ML2, U2, UN2] = removeGaps4UpdateML_UN(ML2, U2, UN2); 
    
    %% 
        MLn = max(ML2(:));
        if MLn < 70
            break;
        else
            node_thr = node_thr + 6000;
        end
    end
    U = U2;
    MS = MS2;
    UN = UN2;
    ML = ML2;


    neighbors = computeNeighbors(U,MLn);

    %% define all edges (taking care of neighborhoods with more than 2 areas)
    %- based on the number of bridging watershed-line voxel between them (i.e. "neighbors" matrix)
    E = defineEdges(UN, neighbors); 
    %% extract properties for each node
    T = nodeProperty(ML, pixdim);

    %% calculate the distance between nodes, being connected by edges
    D = nodeDistance(E, T);

    %% CREATE THE GRAPH  
    G = graph(E(:,1), E(:,2),[], MLn);
    T.degree = degree(G);
    MLWL = double(ML) + (double(MS)*double(MLn+1));

end