function imgS = smooth_image(img, pixdim)
    if isa(img, 'double')
        imgS = zeros(size(img));
    elseif isa(img, 'uint8')
        imgS = uint8(false(size(img)));
    end
    sigma = 0.3 ./ pixdim(1:2); 
   
    for iL=1:size(img,4)
        for iS=1:size(img,3)
            imgS(:,:,iS,iL) = imgaussfilt(img(:,:,iS,iL),sigma);
        end
    end
end
