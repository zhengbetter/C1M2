function imgThr = threshold_img_single(img, thrE_TLS_s)

    %% Threshold the image
    
    %--- Declare variable for thresholded 3D output volume
    imgThr = zeros(size(img),'uint8');
    
    for iS = 1:size(img,3)
        iS
        %% work with a single slice and all color channels
        C = squeeze(img(:,:,iS));
        thrE = thrE_TLS_s(:,:,iS);
        %% segment microglia cells
        %--- threshold the image
        BW1 = C > thrE(2,3); %--- get green with a high threshold
        BW2 = C > thrE(2,2) & C < thrE(1,1); %--- green with low threshold (maximum of int at edges) but excluding red
        BW = BW1 | BW2;
           
        %% segment nuclei
%         BWnuclei = C > thrE(1,2) & C > thrE(2,3); %--- get the nuclei
        
        %% insert thresholded slice into 3D volume
%         imgThr(:,:,iS, 1) = BWnuclei;
        imgThr(:,:,iS) = BW;
        
    end
end