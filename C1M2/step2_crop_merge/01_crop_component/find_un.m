function UN = find_un(U, Ul)
    %% Find unique neighborhood tuples (variable UN)
    if isempty(U)
        UN = [];
    else
        %--- convert cell of number vectors of different length to zero-padded matrix 
        lvn = repmat({max(Ul)},length(U),1);
        pad_zero = @(v, lvn) padarray(v, lvn-length(v),'post');
        UZ = cellfun(pad_zero, U, lvn, 'UniformOutput', false);
        UZ = cell2mat(UZ')';
        %--- find unique 
        UZ = sort(UZ,2);
        [~, i_unique] = unique(UZ,'rows', 'stable');
        UN = U(i_unique);
    end
end