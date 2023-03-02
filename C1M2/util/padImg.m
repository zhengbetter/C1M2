function img_pad = padImg(img,newSize)

    [x_old, y_old, z_old] = size(img);
    if any(size(img) > newSize)
        img_pad = imresize3(img,newSize);
    else
        x_start = round((newSize(1) - x_old) / 2);
        y_start = round((newSize(2) - y_old) / 2);
        z_start = round((newSize(3) - z_old) / 2);
        
        img_pad = uint8(zeros(newSize));
     
    
        img_pad(x_start+1:(x_start+ x_old), y_start+1:(y_start + y_old), z_start+1:(z_start + z_old)) = img;
    end


end