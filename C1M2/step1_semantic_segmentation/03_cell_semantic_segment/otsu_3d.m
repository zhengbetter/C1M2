function img_bw = otsu_3d(img_s)
    
    img_bw = logical(false(size(img_s)));

    for i_slice = 1:size(img_s,3)
        tmp = img_s(:,:,i_slice);
        T = graythresh(tmp);
        img_bw(:,:,i_slice) = imbinarize(tmp,T);
    end
end