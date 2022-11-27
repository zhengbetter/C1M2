function [SNV, somaL, mergedSoma] = one_node_multiple_soma(SNV,somaL)
    %% check whether multiple soma share the same seed-node, and in case merge these soma
    [seedNodes, ~, idxSomaNew] = unique(SNV(:,2), 'stable');
    nSeeds = length(seedNodes);
    mergedSoma = false(nSeeds,1);
    somaN = size(SNV,1);
    if nSeeds < somaN
        %--- re-number soma in order to merge soma and make numbering of soma continuous again
        overlap = zeros(nSeeds,1);
        for i=1:somaN
            overlap(idxSomaNew(i)) = overlap(idxSomaNew(i)) + SNV(i,3);
            if idxSomaNew(i) < i
                somaL(somaL==i) = idxSomaNew(i);
            end
        end
        
        %--- indicate which soma resulted from merging
        for i=1:nSeeds
            mergedSomaT = find(idxSomaNew==i);
            if length(mergedSomaT)>1
                mergedSoma(i) = length(mergedSomaT);
            end
        end
        SNV = [(1:nSeeds)', seedNodes, overlap];
    end
end