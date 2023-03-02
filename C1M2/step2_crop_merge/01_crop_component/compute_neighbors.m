function neighbors = compute_neighbors(U, MLn)
    %% find neighborhood matrix 
    neighbors = zeros(MLn, MLn);
    for i=1:size(U,1)
        
        UT = U{i};
        for j=1:length(UT)-1
            for k=j+1:length(UT)
                neighbors(UT(j),UT(k)) = neighbors(UT(j),UT(k)) + 1;
            end
        end
    end
    %--- make neighborhood matrix symetric
    neighbors = neighbors + neighbors';
end