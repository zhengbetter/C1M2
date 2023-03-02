function UN = is_include_tuple(UN)
    %%  Check for each neighborhood tuple, whether it is included in a longer neighborhood tuple 
    Ul = cellfun(@length,UN); 
    start_idx = [1; find(diff(Ul))+1];
    %---
    include = true(size(UN,1),1);
    for iC = 1:length(start_idx)-1
        for i=start_idx(iC):start_idx(iC+1)-1
            for j=start_idx(iC+1):size(UN,1)
                if all(ismember(UN{i}(:), UN{j}(:)))
                    include(i) = false;
                    break
                end
            end
        end
    end
    UN = UN(include);
end