function T = compute_node_property(ML)
    
    %% extract properties for each node
    % 这个可以换成 regionprops3进行计算
%     fprintf('Extract node properties... ')
    
%     T = regionprops('table',ML,{'Area','Centroid'});
    
%     T.cogI = T.Centroid(:,[2 1 3]); %--- x/y dimension are exchanged by "regionprops"
%     T.cog = (T.cogI .* repmat(pixdim(2:4), height(T), 1)) - repmat(pixdim(2:4)./2, height(T), 1);
%     %---
%     T.vol = T.Area .* prod(pixdim(2:4));
end