function img_eq = enchance_image(img)

    z_ench = floor(size(img,3)*0.2); % enchance the deep images of z axis
    tmp_ench = img(:, :, z_ench:end);
    [hist_d, prct_d] = hist_prct(tmp_ench);
    hist_norm = norm_histogram(prct_d, hist_d);
    img_eq = equalize_stack(tmp_ench, hist_norm);
    img_eq = cat(3, img(:,:,1:z_ench-1), img_eq);

end