function img_segment = cell_semantic_segment_two_channel(img, th1, th2, pixdim,  thr)

    img = double(img);
    img = img./max(img(:));
    
    %% smooth the data
    img_s = smooth_image(img, pixdim);
    
    %% Determine threshold for each slice separately
    thrE_LTS = zeros(2,4, size(img_s, 3));

    for iS = 1:size(img_s,3)
        % work with a single slice and all color channels
        C = squeeze(img_s(:,:,iS,:));
        %% calculate edges
        CE = C;
        method = 'Sobel';
        CE(:,:,1) = edge(C(:,:,1),method);
        CE(:,:,2) = edge(C(:,:,2),method);
            
        %% define thresholds using histogram for edge intensities
        %--- Extract intensities on edges froeach channel
        Red = C(:,:,1);
        Green = C(:,:,2);
        Red = Red(CE(:,:,1)==1);
        Green = Green(CE(:,:,2)==1);
    
        %--- fit Kernel distribution
        Red(Red<=0)=0.0001;
        Green(Green<=0)=0.0001;
        
        pdR = fitdist(Red,'Kernel','Support','positive');
        pdG = fitdist(Green,'Kernel','Support','positive');
        
        thrE = zeros(2,4);
        %--- use percentiles as threshold levels
        x = 0:0.001:1;
        cdfT = pdR.cdf(x);
        %- 5th percentile
        [~, idx] = min((cdfT-5/100).^2);
        locL1 = x(idx);
        %- 20th percentile
        [~, idx] = min((cdfT-20/100).^2);
        locM = x(idx);
        thrE(1,:) = [locL1 locM NaN NaN];
        
        %--- use percentiles as threshold levels
        cdfT = pdG.cdf(x);
        %- 25th percentile
        [~, idx] = min((cdfT-th1/100).^2);
        locM = x(idx);
        %- 55th percentile
        [~, idx] = min((cdfT-th2/100).^2);
        locU1 = x(idx);
        %-----
        thrE(2,:) = [NaN locM locU1 NaN];
        
        thrE_LTS(:,:,iS) = thrE;
        
    end

    %% smooth the thresholds
    thrE_TLS_s = nan(size(thrE_LTS));

    for iL = 1:size(thrE_LTS,1)
        for iT = 1:size(thrE_LTS,2)
            if ~all(isnan(thrE_LTS(iL,iT,:)))
                %--- smooth the curve
                y =squeeze(thrE_LTS(iL,iT,:));
                %--- smooth with moving average and find outliers
                thrE_TLS_s(iL,iT,:) = smooth_moving_average(y, 1);
            end
        end
    end

    %% Threshold the image
    
    img_thr = zeros(size(img_s),'uint8');
    
    for iS = 1:size(img_s,3)
        
        %% work with a single slice and all color channels
        C = squeeze(img_s(:,:,iS,:));
        thrE = thrE_TLS_s(:,:,iS);
        %% segment microglia cells
        %--- threshold the image
        BW1 = C(:,:,2) > thrE(2,3); 
        BW2 = C(:,:,2) > thrE(2,2) & C(:,:,1) < thrE(1,1); 
        BW = BW1 | BW2;
           
        %% segment nuclei
        BWnuclei = C(:,:,1) > thrE(1,2) & C(:,:,2) > thrE(2,3); 
        
        %% insert thresholded slice into 3D volume
        img_thr(:,:,iS, 1) = BWnuclei;
        img_thr(:,:,iS, 2) = BW;
        
    end
    

    img_segment = squeeze(img_thr(:,:,:,2));
    for i =1:size(img_segment,3)
        img_segment(:,:,i) = imfill(img_segment(:,:,i), 'holes');
    end
    for i =1:size(img_segment,2)
        img_segment(:,i,:) = imfill(img_segment(:,i,:), 'holes');
    end
    for i =1:size(img_segment,1)
        img_segment(i,:,:) = imfill(img_segment(i,:,:), 'holes');
    end

    img_segment = bwareaopen(img_segment, thr);

end