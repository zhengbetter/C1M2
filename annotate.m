clear
clc

% This script for annotation and quantification of F4/80 and CD11c
root_path = '/root_path/';
pixdim = [0.5, 0.5, 0.25];  % the resolution of x, y, and z, respectively

channel_names = ["f480", "cd11c"];

for i_stack=1
        
    for i_channel = 1:2

        channel_name = channel_names(i_channel);
        stack_path = strcat(root_path, '/', channel_name, '/c1m2/', num2str(i_stack), '/');
        
        if channel_name == "f480"
            label_channel = "cd11c";
        else
            label_channel = 'f480';
        end
        
        label_img = image2array(strcat(root_path,'/', label_channel, '/c1m2/', num2str(i_stack),'/img/cell_enhance/'));
        
        cell_total = load(strcat(stack_path,  'cell_total.mat'));
        cell_packed = cell_total.cell_packed;
        cell_isolate = cell_total.cell_isolate;

        packed_ring = label_ring_intensity(cell_packed, label_img);
        isolate_ring = label_ring_intensity(cell_isolate, label_img);
        
        if channel_name == "cd11c"
            packed_cls = intensitycurve2cls_green(packed_ring);
            isolate_cls = intensitycurve2cls_green(isolate_ring);
        elseif channel_name == "f480"
            packed_cls = intensitycurve2cls_red(packed_ring);
            isolate_cls = intensitycurve2cls_red(isolate_ring);
        end
        
        save_path = strcat(stack_path, '/',label_channel,'_annotation/');
        if(~exist(save_path, 'file'))
            mkdir(save_path);
        end
        save(strcat(save_path,'packed_annotation.mat'),  'packed_ring', 'packed_cls');
        save(strcat(save_path, 'isolate_annotation.mat'), "isolate_ring", 'isolate_cls');
        
        cls = [packed_cls; isolate_cls];
        packed_bboxes = convert_bbox(table2array(regionprops3(cell_packed, 'BoundingBox')), size(cell_packed), 0);
        isolate_bboxes = convert_bbox(table2array(regionprops3(cell_isolate, 'BoundingBox')), size(cell_isolate), 0);
        packed_image= table2cell(regionprops3(cell_packed, 'Image')); 
        isolate_image = table2cell(regionprops3(cell_isolate, 'Image'));
        packed_bboxes = align_bbox_cell(packed_bboxes, packed_image);
        isolate_bboxes = align_bbox_cell(isolate_bboxes, isolate_image);
        %% label_bbox
        bboxes = [packed_bboxes;isolate_bboxes];
        bboxes_label = annotate_bbox(cls, bboxes, size(label_img));
        merge = cat(4, label_img, bboxes_label{1,1}, bboxes_label{2,1},bboxes_label{3,1}, bboxes_label{4,1});
        array2image(strcat(save_path, 'label_bbox/'), merge);
        
        %% label_cell
        stack_size = size(label_img);
        cell_images = [packed_image; isolate_image];
        merge = [];
        for i_cls = 0:3
            ind = find(cls==i_cls);
            tmp_cls = uint8(zeros(stack_size));
            
            for j =1:size(ind,1)
                tmp_cls(chunk2stack(uint8(cell_images{ind(j),1}), bboxes(ind(j),:), stack_size)==1)=1;
            end
            label_cls = label_img .* tmp_cls;
            merge = cat(4, merge, label_cls);
        end
        
        array2image(strcat(save_path, 'label_cell/'), merge);
        %% curve
        intensity_ring = [packed_ring;isolate_ring];
        plot_intensity_distribution(intensity_ring, []);
        saveas(gcf, strcat(save_path, 'curve.fig'));
        plot_intensity_distribution(intensity_ring, cls);
        saveas(gcf, strcat(save_path, 'cls_curve.fig'));
        close all
    end
end


