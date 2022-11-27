function q= isDirectConnect(p, GCCenter)
    
    r = ismember(p, GCCenter);
    q = sum(r) -2; % 这里这个-2就非常的灵性了，因为它的两端肯定是1，相加就是2
    q = ~q;
end