function SNV = SNVt2SNV(SNVt)

    somaId = unique(SNVt(:,1));
    somaN = size(unique(SNVt(:,1)),1);
        SNV = nan(somaN,3);
        for i=1:somaN
            idx1 = find(SNVt(:,1)==somaId(i));
            [~, idx2] = max(SNVt(idx1, 3));
            SNV(i,:) = SNVt(idx1(idx2),:);
    
        end
end