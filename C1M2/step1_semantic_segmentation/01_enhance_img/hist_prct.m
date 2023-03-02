function [histD, prctD] = hist_prct(img)
    
    binNumbers = 256;
    binEdges = 0:1:binNumbers;
    Z = size(img,3);
    prctD = zeros(Z, 2);
    histD = zeros(Z, binNumbers);
    
    for iS = 1:size(img,3)
        t = img(:,:,iS);
    
        histD(iS,:) = histcounts(t(:),binEdges);
        prctD(iS,:) = prctile(t(:),[1 99]);
    end
    
    num = size(img,1)*size(img,2);
    histD = histD./num*100; 
end