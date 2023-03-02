function cls = intensitycurve2cls_green(intensity_ring)
       
    intensity_ring(intensity_ring>150)=150;
    [k_max, k_ind] = max(intensity_ring, [], 2);
    k_ratio = k_max ./k_ind;
    cls = zeros(size(k_ratio,1),1);
    high = 25;
    med = 13;
    low = 3.5;
    cls(low <= k_ratio & k_ratio < med) = 1;
    cls(med <= k_ratio & k_ratio <= high) = 2;
    cls(k_ratio>high) = 3;
    
    ind = isnan(intensity_ring(:,1));
    cls(ind)=-1;
end