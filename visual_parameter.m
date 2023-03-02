clear
clc

root_path = '/root_path/';
total_properties = [];
for i=1
    cell_total = load(strcat(root_path, num2str(i), '/cell_total.mat'));
    
    packed_parameters =cell_total.packed_properties;

    packed_parameters.isConnect = ones(size(packed_parameters,1),1);
    packed_annotation = load(strcat(root_path, num2str(i), '/cd11c_annotation/packed_annotation.mat'));
    packed_parameters.cls = packed_annotation.packed_cls;

    isolate_parameters = cell_total.isolate_properties;
    isolate_parameters.isConnect = zeros(size(isolate_parameters,1),1);
    isolate_annotation = load(strcat(root_path, num2str(i), '/cd11c_annotation/isolate_annotation.mat'));
    isolate_parameters.cls = isolate_annotation.isolate_cls;

    stack_properties = [packed_parameters;isolate_parameters];
    total_properties = [total_properties; stack_properties];
end

save_path = strcat(root_path, 'parameters/');
if(~exist(save_path, 'file'))
    mkdir(save_path);
end
save(strcat(save_path, 'parameters.mat'), 'total_properties');

% distribution
plot_class_distribution(total_properties)
saveas(gcf, strcat(save_path, 'class_distribution.fig'));

plot_class_isPacked_distribution(total_properties)
saveas(gcf, strcat(save_path, 'cls_distribution.fig'));

plot_cls_vs_cls_short_n(total_properties, 1)
saveas(gcf, strcat(save_path, 'position_distribution_1.fig'));
plot_cls_vs_cls_short_n(total_properties, 3)
saveas(gcf, strcat(save_path, 'position_distribution_3.fig'));

plot_class_parameters(total_properties)
saveas(gcf, strcat(save_path, '/region_props.fig'));
close all
