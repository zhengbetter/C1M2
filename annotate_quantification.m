clear
clc

% This script for annotation and quantification of F4/80 and CD11c

root_path = '/data2/zhenghao/cell_segment/dataset/standard/upload/';
pixdim = [0.5, 0.5, 0.25];  % the resolution of x, y, and z, respectively

%% step1: merge two channel cells
for i_stack = 1
    
    red_multi = load(strcat(root_path, 'f480/c1m2/',num2str(i_stack),'/cell_multi.mat'));
    red_multi = red_multi.cell_multi;
    
    red_one = load(strcat(root_path, 'f480/c1m2/',num2str(i_stack),'/cell_one.mat'));
    red_one = red_one.cell_one;
    red_semantic = logical(red_one) | logical(red_multi);
    
    green_multi = load(strcat(root_path, 'cd11c/c1m2/', num2str(i_stack), '/cell_multi.mat'));
    green_multi = green_multi.cell_multi;
    
    green_one = load(strcat(root_path, 'cd11c/c1m2/',num2str(i_stack),'/cell_one.mat'));
    green_one = green_one.cell_one;
    green_semantic = logical(green_one) | logical(green_multi);
    
    cell_one = red_one;
    for i= 1:max(green_one(:))
        tmp_green = green_one==i;
        ratio = sum(tmp_green & red_semantic , 'all')/sum(tmp_green(:));
        if ratio < 0.2
            cell_one(tmp_green) = max(cell_one(:))+1;
        end
    end
    
    cell_multi = red_multi;
    for i= 1:max(green_multi(:))
        tmp_green = green_multi==i;
        ratio = sum(tmp_green .* red_semantic, 'all')/sum(tmp_green(:));
        if ratio < 0.2
            cell_multi(tmp_green) = max(cell_multi(:))+1;
        end
    end
    
    [cell_multi, multi_bboxes, multi_cell_images, multi_parameters] = instance2bbox_images(cell_multi, pixdim);
    [cell_one, one_bboxes, one_cell_images, one_parameters] = instance2bbox_images(cell_one, pixdim);
    
    save_path = strcat(root_path, 'annotate_quantification/', num2str(i_stack), '/');
    if(~exist(save_path, 'file'))
        mkdir(save_path);
    end
    
    merge = cat(4, cell_multi, cell_one, red_multi, red_one, green_multi, green_one);
    merge = uint8(merge).*255;
    mat2image(strcat(save_path, 'compare_merge_channels/'), merge,[],0);
    
    save(strcat(save_path,'cellMat.mat'), "cell_multi", 'multi_bboxes',"multi_cell_images", ...
        "cell_one","one_bboxes", 'one_cell_images','-v7.3')
end


%% step2: annotation and quantification
channnel_names = ["f480", "cd11c"];
for i_stack=1
    
    stack_path = strcat(root_path, 'annotate_quantification/', num2str(i_stack), '/');
    cell_mat = load(strcat(stack_path, 'cellMat.mat'));
    cell_multi = cell_mat.cell_multi;
    cell_one = cell_mat.cell_one;
    
    for i_channel = 1:2
        
        channel_name = channel_names(i_channel);
        img = image2mat(strcat(root_path, '/', channel_name,'/c1m2/', num2str(i_stack), '/img/cell_enchance/'));
        
        multi_ring = label_ring_intensity(cell_multi, img);
        one_ring = label_ring_intensity(cell_one, img);
        
        if channel_name == "cd11c"
            multi_cls = intensitycurve2cls_green(multi_ring);
            one_cls = intensitycurve2cls_green(one_ring);
        elseif channel_name == "f480"
            multi_cls = intensitycurve2cls_red(multi_ring);
            one_cls = intensitycurve2cls_red(one_ring);
        end
        
        save_path = strcat(stack_path, '/',channel_name,'_annotation/');
        if(~exist(save_path, 'file'))
            mkdir(save_path);
        end
        save(strcat(save_path,'cell_multi.mat'),  'multi_ring', 'multi_cls');
        save(strcat(save_path, 'cell_one.mat'), "one_ring", 'one_cls');
        
        cls = [multi_cls; one_cls];
        %% label_bbox
        multi_bboxes = cell_mat.multi_bboxes;
        one_bboxes = cell_mat.one_bboxes;
        bboxes = [multi_bboxes;one_bboxes];
        bboxes_label = label_on_stack(cls, bboxes, size(img));
        merge = cat(4, img, bboxes_label{1,1}, bboxes_label{2,1},bboxes_label{3,1}, bboxes_label{4,1});
        mat2image(strcat(save_path, 'label_bbox/'), merge,[],0);
        
        %% label_cell
        stack_size = size(img);
        multi_cell = cell_mat.multi_cell_images;
        one_cell = cell_mat.one_cell_images;
        cell_images = [multi_cell; one_cell];
        merge = [];
        for i_cls = 0:3
            ind = find(cls==i_cls);
            tmp_cls = uint8(zeros(stack_size));
            
            for j =1:size(ind,1)
                tmp_cls(chunk2stack(uint8(cell_images{ind(j),1}), bboxes(ind(j),:), stack_size)==1)=1;
            end
            label_cls = img .* tmp_cls;
            merge = cat(4, merge, label_cls);
        end
        
        mat2image(strcat(save_path, 'label_cell/'), merge,[],0);
        %% curve
        intensity_ring = [multi_ring;one_ring];
        ring_intensity_distribution(intensity_ring, []);
        saveas(gcf, strcat(save_path, 'curve.fig'));
        ring_intensity_distribution(intensity_ring, cls);
        saveas(gcf, strcat(save_path, 'cls_curve.fig'));
        close all
    end
end


