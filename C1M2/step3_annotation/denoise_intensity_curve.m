function intensity = denoise_intensity_curve(intensity, thr)
    
    intensity2 = intensity(:,2:end);
    intensity1 = intensity(:,1:end-1);
    delta = intensity1- intensity2;
    for i=1:size(delta,1)
        ind = find(delta(i,:)>thr,1,'first');
        if ~isempty(ind)
            intensity(i,ind+1:end)=nan;
        end
    end

    bg = sort(intensity(:,1:2));
    bg = mean(bg(1:20));
    intensity = intensity - bg;
    intensity(intensity<0)=0;
    
end
