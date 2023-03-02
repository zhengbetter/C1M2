function ML = relabelML(ML, labelOldNew)

    %% change lable in variable ML
    nChange = size(labelOldNew,1);
    for j=1:nChange
        ML(ML==labelOldNew(j,1)) = labelOldNew(j,2);
    end
    
end