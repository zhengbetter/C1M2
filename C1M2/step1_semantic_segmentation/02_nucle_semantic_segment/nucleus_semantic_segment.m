function img_bw = nucleus_semantic_segment(img)
       
    img_1 = img(:,:,1:80);
    img_bw1 = false(size(img_1));
    for i_slice = 1:size(img_1,3)
        tmp = img_1(:,:,i_slice);
        T = graythresh(tmp);
        img_bw1(:,:,i_slice) = imbinarize(tmp,T);
    end

    img_2 = img(:,:,81:end);
    img_bw2 = false(size(img_2));
    for i_slice=1:size(img_2,3)
        i_image = img_2(:,:,i_slice);
        T = adaptthresh(i_image, 0.000001);
        img_bw2(:,:,i_slice) = imbinarize(i_image, T);
    end

    img_bw = cat(3, img_bw1, img_bw2);

end