function plot_class_parameters(properties)
    
    tiledlayout(2,2)

    clsOrder = {'None Isolate', 'None Connect', 'Low Isolate', ...
        'Low Connect', 'Med Isolate',  'Med Connect','High Isolate', 'High Connect'};
%     properties.Class = categorical(properties.cls, [0,1,2,3], clsOrder);
    properties.cls_connect = properties.cls*2+properties.isConnect;
    properties.Class_Connect = categorical(properties.cls_connect, 0:7, clsOrder);

    % Left axes
    ax1 = nexttile;
    boxchart(ax1, properties.Volume,'GroupByColor',properties.Class_Connect,...
            'MarkerStyle','none', 'Notch', 'on')
    ylabel(ax1,'Volume')
%     xlabel('Volume')
    legend
    
    % Right axes
    ax2 = nexttile;
    boxchart(ax2,properties.Extent,'GroupByColor',properties.Class_Connect,...
        'MarkerStyle','none', 'Notch', 'on')
    ylabel(ax2,'Extent')
    legend

    ax3 = nexttile;
    boxchart(ax3,properties.Solidity,'GroupByColor',properties.Class_Connect,...
            'MarkerStyle','none', 'Notch', 'on')
    ylabel(ax3,'Solidity')
    legend

    ax4 = nexttile;
    boxchart(ax4,properties.SurfaceArea,'GroupByColor',properties.Class_Connect,...
            'MarkerStyle','none', 'Notch', 'on')
    ylabel(ax4,'SurfaceArea')
    legend

end
