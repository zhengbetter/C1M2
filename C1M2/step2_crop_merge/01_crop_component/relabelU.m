
function U = relabelU(U, labelOldNew)
    %% change lable in variable U

    Uleng = cellfun(@numel, U);
    M = max(Uleng);
    
    padfun = @(k)[U{k}; zeros(M-Uleng(k),1)];
    Upad = arrayfun(padfun, 1:numel(Uleng), 'un', 0);

    Umat = cell2mat(Upad);

    for i_c = 1:size(labelOldNew,1)
        Umat(Umat==labelOldNew(i_c,1)) = labelOldNew(i_c,2);
    end

    fun2 = @(k){Umat(1:Uleng(k),k)};
    U = arrayfun(fun2, 1:numel(Uleng),'un',1);
    U = U';
    
    U = cellfun(@unique, U, 'un', 0);
end