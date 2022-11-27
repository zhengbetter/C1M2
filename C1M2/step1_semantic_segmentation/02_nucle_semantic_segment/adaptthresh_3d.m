function img_bw = adaptthresh_3d(image, sensitivity)
    
    img_bw = false(size(image));

    for i=1:size(image,3)
        i_image = image(:,:,i);
        T = adaptthresh(i_image,sensitivity);
        img_bw(:,:,i) = imbinarize(i_image, T);
    end
end