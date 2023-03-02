function  [ML, U, UN] = remove_gaps_update_ML_UN(ML, U,UN)
    %% remove gaps in the list of labels, due to merging of areas
    label_old = unique(ML(:));
    label_old(label_old==0) = []; 

    UNl = cellfun(@length,UN);
    UNlx = [0;UNl];
    UNV = vertcat(UN{:});
    
    Ul = cellfun(@length, U);
    Ulx = [0;Ul];
    UV = vertcat(U{:});
    %---
    gaps_n = max(label_old) - length(label_old); 
    if gaps_n>0
        
        label_old = [0; label_old(:)]; 
        dd = diff(label_old);
        idx = find(dd>1);
        offset = dd(idx) - 1;
        for i=length(idx):-1:1
            label_border = label_old(idx(i));
            ML(ML>label_border) = ML(ML>label_border) - offset(i);
            UNV(UNV>label_border) = UNV(UNV>label_border) - offset(i);
            UV(UV>label_border) = UV(UV>label_border)-offset(i);
            
        end
    end
    for i=1:length(UN)
        UN{i} = UNV(sum(UNlx(1:i))+1:sum(UNlx(1:i+1)));
    end
    
    for i=1:length(U)
        U{i} = UV(sum(Ulx(1:i)) + 1:sum(Ulx(1:i+1)));
    end
