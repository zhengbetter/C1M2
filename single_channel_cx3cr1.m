clear
clc

% This script for CX3CR1 cells 

root_path = '/data2/zhenghao/cell_segment/dataset/standard/upload/cx3cr1/';
pixdim = [0.8,0.8,2.5]; % the resolution of x, y, and z, respectively
merge_basi_vol_thr=500; % the threshold of block volume
nuclei_volume_thr = 300; % the threshold of nuclei vol

for i_stack = 1
    cell_ori = image2mat(strcat(root_path, 'example/', num2str(i_stack),'/cell/'));
    cell_eq = medfilt3(cell_ori, [3,3,3]);
    cell_semantic = otsu_3d(cell_eq);

    cell_semantic = smooth3(cell_semantic, 'box', [3,3,3])>0.5; % smooth the semantic results
    cell_semantic = bwareaopen(cell_semantic,300); % remove small object

    merge = cat(4, cell_ori, cell_eq, uint8(cell_semantic).*255, uint8(cell_semantic).*255);  % compare semantic result
    mat2image(strcat(root_path, 'c1m2/',num2str(i_stack),'/img/compare_cell_semantic/'), merge, [], 0);

    [filter_nuclei, nuclei_100] = generate_fake_nuclei(cell_semantic, 1, nuclei_volume_thr, pixdim);
    merge = cat(4, uint8(cell_semantic).*255, uint8(filter_nuclei).*255, nuclei_100.*255);
    mat2image(strcat(root_path, 'c1m2/',num2str(i_stack),'/img/compare_fake_nucleus/'), merge, [], 0); 

    %% instance segment
    [cell_non, cell_one, cell_multi] = filter_connected_component(filter_nuclei, cell_semantic);

    % parameters 1:single cell volume
    single_volume = 4000; % mannual setting

    % parameters 2:the rules of link and volume
    link_volume_rules=[0,100,0.1;
        100,200,0.15;
        200,300,0.25;
        300,500,0.5;
        500,700,3;
        700,1500,4;
        1500,6000,20;];

    [cell_one, cell_multi] = crop_merge(cell_one, cell_multi, filter_nuclei, ...
        single_volume, link_volume_rules, merge_basi_vol_thr, 'graph');

    % cell multi
    semantic_bboxes = convert_bbox(table2array(regionprops3(logical(cell_multi), 'BoundingBox')), size(cell_multi), 0);
    semantic_cell= table2cell(regionprops3(logical(cell_multi), 'Image'));
    [cell_multi, multi_bboxes, multi_cell,multi_parameters] = instance2bbox_images(cell_multi, pixdim);

    save(strcat(root_path, 'c1m2/', num2str(i_stack),'/cell_multi.mat'), 'cell_multi', "semantic_bboxes","semantic_cell", ...
        "multi_bboxes", "multi_cell", 'multi_parameters', '-v7.3');

    % cell one
    [cell_one, one_bboxes, one_cell, one_parameters] = instance2bbox_images(cell_one, pixdim);
    save(strcat(root_path, 'c1m2/',num2str(i_stack),'/cell_one.mat'), 'cell_one', "one_bboxes", "one_cell", 'one_parameters', '-v7.3');

    % % visual
    merge = cat(4, uint8(logical(cell_one)).*255, uint8(decode_cell(cell_multi, 12)).*255);
    mat2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/instacnce/'), merge, [],0);

    total_cells = cell_one;
    for i_m=1:max(cell_multi(:))
        total_cells(cell_multi==i_m) = max(total_cells(:))+1;
    end
    save(strcat(root_path,'c1m2/', num2str(i_stack),'/segment_cells.mat'), "cell_non", "cell_one", "cell_multi", "total_cells", '-v7.3')
end

