function labelWeight = edge2weight(sN,eN, edge, weight)
    
    labelWeight = zeros(length(sN),1);
    for j = 1:size(sN,2)
        idx = find(edge(:,1)==sN(j) & edge(:,2)==eN(j)); 
        if isempty(idx)
            idx = find(edge(:,2)==sN(j) & edge(:,1)==eN(j));
        end
        labelWeight(j) = weight(idx);
    end
    labelWeight = round(labelWeight);
        
end