function cell_segment = cell_semantic_segment_single_channel(img, th1, th2,pixdim)
    
    %% smooth the data
    imgS = double(img);
    imgS = smooth_image(imgS, pixdim);
    imgS = imgS./max(imgS(:));

    thrE_TLS_s = determine_threshold_single(imgS, th1, th2);
    cell_segment = threshold_img_single(imgS, thrE_TLS_s);
    
%     cell_segment = squeeze(imgThr(:,:,:,2));
    for i =1:size(cell_segment,3)
        cell_segment(:,:,i) = imfill(cell_segment(:,:,i), 'holes');
    end
    for i =1:size(cell_segment,2)
        cell_segment(:,i,:) = imfill(cell_segment(:,i,:), 'holes');
    end
    for i =1:size(cell_segment,1)
        cell_segment(i,:,:) = imfill(cell_segment(i,:,:), 'holes');
    end

end