function    plot_class_isPacked_distribution(properties)

    properties.cls_connect = properties.cls*2+properties.isConnect;

    count = zeros(8,1);

    for i=0:7
        count(i+1,1) = sum(properties.cls_connect==i);
    end
    cell_rate = reshape(count, [],4)';
    cell_rate = cell_rate ./ sum(cell_rate,2);
    figure,bar(cell_rate, 'stacked')
    legend('Isloate', 'Packed')
end
