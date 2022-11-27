function nucle_s = crop_nucle_volume(tmp_cell, tmp_nucle, v_thr, r_start, delt_r,pixdim)
        
    nucle_new = tmp_nucle;
    nucle_s = false(size(tmp_nucle));

    while true
        [nucle_mat] = bwlabeln(nucle_new);

        nucle_volume = table2array(regionprops3(nucle_mat,'Volume'));
        [max_volume, ~] = max(nucle_volume);
        
        ind = find(nucle_volume<v_thr);
        if ~isempty(ind)
            for i=1:size(ind,1)
                nucle_s = nucle_s | nucle_mat==ind(i);
            end

        end


        if max_volume > v_thr

            r_start = r_start+delt_r;
            nucle_new = imerode(tmp_cell, defineCenterStructure(pixdim, r_start)).*tmp_nucle;

            if sum(nucle_new,'all') ==0
                nucle_new = imerode(tmp_cell, defineCenterStructure(pixdim, r_start-delt_r)).*tmp_nucle;
                nucle_s = nucle_new | nucle_s;
                break;
            end

        else
            break;
        end
    end
end