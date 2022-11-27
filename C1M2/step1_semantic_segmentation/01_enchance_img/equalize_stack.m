function img_eq = equalize_stack(img, hist_norm)

    img_eq = uint8(zeros(size(img)));
    
    for iS = 1:size(img,3)
        img_eq(:,:,iS) = histeq(img(:,:,iS),hist_norm);
    end
end