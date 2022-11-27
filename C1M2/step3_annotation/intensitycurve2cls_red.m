function cls = intensitycurve2cls_red(intensity_ring)
    
    cls = zeros(size(intensity_ring,1),1);
    intensity_ring_4 = intensity_ring(:,4);
    cls(intensity_ring_4 > 80)=3;
    cls(intensity_ring_4 <80 & intensity_ring_4 > 50)=2;
    cls(intensity_ring_4 < 50 & intensity_ring_4 > 15)=1;

    intensity_max = max(intensity_ring, [], 2);
    cls(intensity_max>20 & intensity_max<60)=1;
    ind = isnan(intensity_ring_4(:,1));
    cls(ind)=-1;
end