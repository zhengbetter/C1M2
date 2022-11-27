function intensity_ring = label_ring_intensity(cell_mat, labelImg)
    
    cell_n = max(cell_mat(:));
    intensity_ring = cell(cell_n, 1);
    len = 30;

    parfor i = 1:cell_n
        each_cell = (cell_mat==i);

        ind_intensity = 1;
        interval = 1;
        cell_intensity = NaN(len,1);
        for j=0:interval:1000
            ring = uint8(find_ring(each_cell, j,j+interval));
            ring_voxel = sum(ring,'all');
            if ring_voxel>0

                cell_intensity(j+1) = sum(ring.*labelImg, 'all')/ring_voxel;
                ind_intensity = ind_intensity + 1;
            else
                break;
            end
        end
        intensity_ring{i,1} = cell_intensity;
    end

    inten_l= cellfun(@length,intensity_ring);
    ind = find(inten_l >len);
    if ~isempty(ind)
        for i=1:size(ind,1)
            intensity_ring{ind(i),1}=NaN(len,1);
        end
    end

    intensity_ring = reshape(cell2mat(intensity_ring), len, [])';
    intensity_ring = denoise_intensity_curve(intensity_ring,10);

end