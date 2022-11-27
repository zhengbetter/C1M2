function filePath = obtain_file_paths(root_path)
    filePath = dir(root_path);
    [n, ~] = size(filePath);

    i_del = [];
    for x_s = 1:n
        if( isequal(filePath(x_s).name, '.' ) || isequal(filePath(x_s).name, '..' ))
            i_del = [i_del;x_s];
        end
    end
    filePath(i_del) = [];

end