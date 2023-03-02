function thrE_TLS_s = determine_threshold_single(imgSCrop, th1, th2)

    %% Determine threshold for each slice separately
    
    thrE_LTS = zeros(2,4, size(imgSCrop, 3));

    for iS = 1:size(imgSCrop,3)
    
        %% work with a single slice and all color channels
        C = squeeze(imgSCrop(:,:,iS));
    
        %% calculate edges
        method = 'Sobel';
        CE = edge(C,method);
            
        %% define thresholds using histogram for edge intensities
        %--- Extract intensities on edges froeach channel
        C = C(CE==1);    
    
        %--- fit Kernel distribution
        pdC = fitdist(C,'Kernel','Support','positive');
        
        thrE = zeros(2,4);
        
        %--- use percentiles as threshold levels
        x = 0:0.001:1;
        cdfT = pdC.cdf(x);
        %- 5th percentile
        [~, idx] = min((cdfT-5/100).^2);
        locL1 = x(idx);
        %- 20th percentile
        [~, idx] = min((cdfT-20/100).^2);
        locM = x(idx);
        %-----
        thrE(1,:) = [locL1 locM NaN NaN];
        
     
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
    %x = (1:size(thrE_LTS,3))';
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
end
