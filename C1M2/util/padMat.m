function mat_pad = padMat(mat,newSize)

    if any(size(mat)>newSize)
        [x_old, y_old, ~] = size(mat);

        if x_old > newSize(1)
            delt = floor(x_old / (x_old - newSize(1)));
            mat(1:delt:end, :, :) =[];
        end
        if y_old > newSize(2)
            delt = floor(y_old / (y_old - newSize(2)));
            mat(:, 1:delt:end, :) =[];
        end
    end
    
    [x_old, y_old, z_old] = size(mat);
    x_start = round((newSize(1) - x_old) / 2);
    y_start = round((newSize(2) - y_old) / 2);
    z_start = round((newSize(3) - z_old) / 2);
    
    mat_pad = double(zeros(newSize));    

    mat_pad(x_start+1:(x_start+ x_old), y_start+1:(y_start + y_old), z_start+1:(z_start + z_old)) = mat;
    


end