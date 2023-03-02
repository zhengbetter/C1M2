function [U, Uind, Ul, UN, ML,MS] = updateU_UN_ML_MS(U, Uind, UN,ML,MS,labelOldNew)
    %--- change lable in variable UN
    UN = relabelU(UN, labelOldNew);
    UNl = cellfun(@length,UN);
    UN(UNl==1,:) = [];

    U = relabelU(U, labelOldNew);
    Ul = cellfun(@length,U);

    %--- give watershed-line voxel between merged areas an area-label
    ML(Uind(Ul==1)) = [U{Ul==1}];

    MS(Uind(Ul==1)) = 0;

    U(Ul==1,:) = [];
    Uind(Ul==1,:) = [];
    Ul(Ul==1) = [];
    
    ML = relabelML(ML, labelOldNew);
end