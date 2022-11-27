clear
clc

% This script for CD11c cells

root_path = '/data2/zhenghao/cell_segment/dataset/standard/upload/cd11c/';
pixdim = [0.5, 0.5, 0.25]; % the resolution of x, y, and z, respectively
merge_basi_vol_thr = 500;  % the threshold of block volume

for i_stack = [1,2]

        %% semantic
        % nucleus segment
        nucleus_ori =image2mat(strcat(root_path,  'example/', num2str(i_stack), '/nucleus/'));

        fprintf('start enchance nuclei\n')
        nucleus_eq = enchance_image(nucleus_ori);

        fprintf('start segment nuclei\n')
        nuclei_segment = nucleus_semantic_segment(nucleus_eq);

        % cell segment
        cell_ori = image2mat(strcat(root_path, 'example/', num2str(i_stack), '/cell/'));

        fprintf('start enchance cells\n')
        cell_eq = enchance_image(cell_ori);
        mat2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/cell_enchance/'), cell_eq, [], 0)

        fprintf('start semantic segment cells\n')
        cell_semantic = cell_semantic_segment_two_channel(cat(4, nucleus_ori, cell_eq), 65,85, pixdim, 6000);
        mat2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/cell_semantic/'), uint8(cell_semantic).*255, [], 0);
        merge = cat(4, cell_ori, cell_eq, uint8(cell_semantic).*255); % compare cell semantic segment results
        mat2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/compare_cell_semantic/'), merge, [], 0);

        % filter nuclei
        filter_nuclei = bwareaopen(nuclei_segment & cell_semantic, 50);
        mat2image(strcat(root_path, 'c1m2/', num2str(i_stack),'/img/nucleus_segment/'), uint8(filter_nuclei).*255, [], 0);

        % compare nucleus segment results
        merge = cat(4, nucleus_ori, nucleus_eq, uint8(nuclei_segment).*255, uint8(filter_nuclei).*255);
        mat2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/compare_nucleus/'), merge, [], 0);

        %% instance segment
        fprintf('start filter connected components\n')
        [cell_non, cell_one, cell_multi] = filter_connected_component(filter_nuclei, cell_semantic);

        % parameters 1:single cell volume
        single_volume = 15000; % mannual setting

        fprintf('single cell volume is %d\n', single_volume)

        % parameters 2:the rules of link and volume
        fprintf('start instance segment\n')
        link_volume_rules=[ 50,150,0.1;
                            150,300,0.3;
                            300,400,0.5;
                            400,500,0.8;
                            500,600,1.0;
                            600,700,1.2;
                            700,800,1.8;
                            800,1000,3;
                            1000,1300,6;
                            1300,1500,9;
                            1500,2000,12;
                            2000,6000,14];


        [cell_one, cell_multi] = crop_merge(cell_one, cell_multi, filter_nuclei, ...
            single_volume, link_volume_rules, merge_basi_vol_thr, 'graph');

        % cell multi quantification
        semantic_bboxes = convert_bbox(table2array(regionprops3(logical(cell_multi), 'BoundingBox')), size(cell_multi), 0);
        semantic_cell= table2cell(regionprops3(logical(cell_multi), 'Image'));
        [cell_multi, multi_bboxes, multi_cell,multi_parameters] = instance2bbox_images(cell_multi, pixdim);

        save(strcat(root_path, 'c1m2/',num2str(i_stack),'/cell_multi.mat'), 'cell_multi', "semantic_bboxes","semantic_cell", ...
            "multi_bboxes", "multi_cell", 'multi_parameters', '-v7.3');

        % cell one quantification
        [cell_one, one_bboxes, one_cell, one_parameters] = instance2bbox_images(cell_one, pixdim);
        save(strcat(root_path, 'c1m2/',num2str(i_stack),'/cell_one.mat'), 'cell_one', "one_bboxes", "one_cell", 'one_parameters', '-v7.3');

        merge = cat(4, uint8(logical(cell_one)).*255, uint8(decode_cell(cell_multi, 12)).*255);
        mat2image(strcat(root_path, 'c1m2/', num2str(i_stack),'/instacnce/'), merge, [],0);

        total_cells = cell_one;
        for i_m=1:max(cell_multi(:))
            total_cells(cell_multi==i_m) = max(total_cells(:))+1;
        end

        save(strcat(root_path,'c1m2/', num2str(i_stack), '/cellMat.mat'), "cell_non", "cell_one", "cell_multi", "total_cells", '-v7.3')

end
