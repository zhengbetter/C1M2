function plot_cls_vs_cls_short_n(properties, n)

    centroid = properties.Centroid;
    ShortestClass = cell(size(properties,1),1);
    
    
    for i =1:size(centroid,1)
        dist = sum(sqrt((centroid(i,:) - centroid).^2),2);

        [~,ind] = sort(dist, 'ascend');
        ShortestClass{i} = properties.cls(ind(2:n+1))';
    end
    
    ShortestClass = cell2mat(ShortestClass);
    
    count = zeros(4,4);
    for i = 0:3
        
        cls_ind = properties.cls==i;
        for j = 0:3
            
            count(i+1,j+1) = sum(ShortestClass(cls_ind,:)==j, 'all');
        end
    end  
    count = count ./ sum(count,2);
%     figure,bar(count, 'stacked')
    figure,bar(count)
    legend('None', 'Low', 'Med', 'High')
    
end