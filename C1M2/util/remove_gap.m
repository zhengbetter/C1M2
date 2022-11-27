function mat = remove_gap(mat)
    label_old = unique(mat(:));
    label_old(label_old==0) = [];
    gaps_n = max(label_old) - length(label_old);

    if gaps_n>0
        label_old = [0; label_old(:)]; 
        dd = diff(label_old);
        idx = find(dd>1);
        offset = dd(idx) - 1;
        for i=length(idx):-1:1
            label_border = label_old(idx(i));
            mat(mat>label_border)=mat(mat>label_border)-offset(i);
        end
    end
end
