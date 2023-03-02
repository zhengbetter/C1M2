function tmp_nucle = erode_cell(tmp_nucle, tmp_cell, v_thr, nucle_r, delt_r, pixdim)

    
        [tmp_nucle_mat] = bwlabeln(tmp_nucle);
        tmp_nucle_volume = table2array(regionprops3(tmp_nucle_mat,'Volume'));
    
        ind = find(tmp_nucle_volume>v_thr);
        if ~isempty(ind)
    
            for j=1:size(ind,1)
                tmp_nucle_j = tmp_nucle_mat==ind(j);
                tmp_nucle(tmp_nucle_j)=0;
                nucle_new = crop_nucle_volume(tmp_cell, tmp_nucle_j, v_thr, nucle_r, delt_r,pixdim);     
                tmp_nucle = tmp_nucle | nucle_new;
            end
        end
