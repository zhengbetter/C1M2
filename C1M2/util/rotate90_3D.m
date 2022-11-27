function img_r = rotate90_3D(img)
    img_r = uint8(zeros(size(img)));
    for i=1:size(img,3)
        img_r(:,:,i) = imrotate(img(:,:,i), -90);
    end
end