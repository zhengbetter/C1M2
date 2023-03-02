function mat_file = image2array(image_path)

    file_path = dir(image_path);
    [n, ~] = size(file_path);
    
    % delete . and .. file
    i_del = [];
    for i = 1:n
        if( isequal(file_path(i).name, '.' ) || isequal(file_path(i).name, '..' ))
            i_del = [i_del;i];
        end
    end
    file_path(i_del) = [];
        
    image1 = imread(strcat(file_path(1).folder,'/',file_path(1).name));
    [x_size,y_size,channel] = size(image1);

    if channel == 1
        if isa(image1, 'uint8')
            mat_file = uint8(false(x_size, y_size,n-2));
        elseif isa(image1, 'logical')
            mat_file = false(x_size, y_size,n - 2);
        elseif isa(image1, 'uint16')
            mat_file = uint16(false(x_size, y_size, n-2));
        end
            
       for i = 1:n-2
            mat_file(:,:,i) = imread(strcat(file_path(i).folder,'/',file_path(i).name));
        end
        
    else
        if isa(image1, 'uint8')
            mat_file = uint8(false(x_size, y_size,channel, n - 2));
        elseif isa(image1, 'logical')
            mat_file = false(x_size, y_size,channel, n - 2);
        elseif isa(image1, 'uint16')
            mat_file = uint16(false(x_size, y_size, channel, n-2));
        end
        
        for i = 1:n-2
            mat_file(:,:,:,i) = imread(strcat(file_path(i).folder,'/',file_path(i).name));
        end
    end
    
    
end