function merge = find_interlaced_tuple(UN)
    %% find interlaced tuples in UN, and find nodes overlapping between interlaced tuples
    UNl = cellfun(@length,UN);
    start_idx = find(UNl==3,1,'first');
    interlaced = false(length(UN), length(UN));
    merge = cell(0);
    k=0;
    for i=start_idx:length(UN)
        for j=i+1:length(UN)
            overlap = ismember(UN{i}(:), UN{j}(:));
            if sum(overlap) > 1
                k=k+1;
                interlaced(i,j) = true;
                merge{k} = UN{i}(overlap);
            end
        end
    end

end