function [MLWL, T, E, D, neighbors] = crop_component(img_bw, node_thr)

   
    %% watershed 
    M = logical(img_bw); 
    conn = 18;
    MD = bwdist(~M);
    MI = -MD;
    ML = watershed(MI, conn);
  
    ML(~M) = 0;
    MS = M;
    MS(ML>0) = 0;

    %% check for all voxel on the watershed-line, which cluster they are bordering with
    [U, Uind] = wsline2nighborhood(ML, MS);
    if ~isempty(U)
        Ul = cellfun(@length,U);
        [U, Ul, Uind] = remove_voxel_01(U,Ul, Uind);
        UN = find_un(U, Ul);
        UN = is_include_tuple(UN);
        merge = find_interlaced_tuple(UN);
        labelOldNew = label_new_interlaced_tuple(merge, ML, node_thr); 
        [U, ~, ~, UN, ML,MS] = updateU_UN_ML_MS(U, Uind, UN,ML,MS,labelOldNew);
        [ML, U, UN] = remove_gaps_update_ML_UN(ML, U, UN); 
        MLn = max(ML(:));
        neighbors = compute_neighbors(U,MLn);
        if ~isempty(U)
            E = define_edges(UN, neighbors); 
            T = regionprops3(ML,{'Centroid'});
            D = compute_node_distance(E, T);
            G = graph(E(:,1), E(:,2),[], MLn);
            T.degree = degree(G);
            MLWL = double(ML) + (double(MS)*double(MLn+1));
        else
            MLWL = ML;
            T = [];
            E=[];
            D =[];
            neighbors=[];
        end
    else
        MLWL = ML;
        T = [];
        E=[];
        D =[];
        neighbors=[];
    end
end