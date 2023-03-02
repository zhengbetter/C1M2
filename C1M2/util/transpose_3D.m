function img_t = transpose_3D(img)
    if isa(img, 'double')
        img_t = double(zeros(size(img)));
    elseif isa(img, 'uint8')
        img_t = uint8(false(size(img)));
    elseif isa(img, 'logical')
        img_t = logical(img);
    else
        error('data type is not shibie')
    end
        for i = 1:size(img,3)
            img_t(:,:,i) = img(:,:,i)';
        end
end