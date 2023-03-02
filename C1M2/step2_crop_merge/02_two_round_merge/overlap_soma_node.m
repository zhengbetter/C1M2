function [SNV, SNVt, somaL] = overlap_soma_node(somaL, ML)
    soma = somaL;
    soma(soma>0)=1;
    % find for each soma the node with the largest overlap (SNV: soma-id, node-id, voxel-count)
    [SNVt, ~, iSN] = unique([somaL(soma>0) ML(soma>0)],'rows');
    %--- calculate number of voxel for each soma-node pair
    for i=1:size(SNVt,1)
        SNVt(i,3) = sum(iSN==i);
    end
    %--- remove overlaps with watershed lines (which are merged to the background; label=0)
    idxBackground = SNVt(:,2)==0;
    SNVt(idxBackground,:) = [];

    %--- find the node with the largest overlap
    SNV = SNVt2SNV(SNVt);
    %% nan 
    ind = find(isnan(SNV(:,2)));
    SNV(ind,:) = [];
    SNV(:,1) = remove_gap(SNV(:,1));
    for i =1:size(ind,1)
        somaL(somaL==ind(i)) = 0;
    end
    somaL = remove_gap(somaL);
    

end