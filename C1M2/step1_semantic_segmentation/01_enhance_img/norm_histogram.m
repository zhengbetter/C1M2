function hist_norm = norm_histogram(prct_d, hist_d)

    prct_range = prct_d(:,2)-prct_d(:,1);
    prct_rmax = max(prct_range);
    idx = prct_range>prct_rmax*0.95;
    hist_norm = mean(hist_d(idx,:),1);
end