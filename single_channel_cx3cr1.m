clear
clc

% This script for CX3CR1 cells 

root_path = '/root_path/';

pixdim = [0.8,0.8,2.5]; % the resolution of x, y, and z, respectively
merge_basi_vol_thr=50; % the threshold of block volume
nuclei_volume_thr = 300; % the threshold of nuclei vol

for i_stack = 1
    cell_ori = image2array(strcat(root_path, 'example/', num2str(i_stack),'/cell_aj/'));

    cell_eq = medfilt3(cell_ori, [3,3,3]);
    cell_semantic = otsu_3d(cell_eq);

    cell_semantic = smooth3(cell_semantic, 'box', [3,3,3])>0.5; % smooth the semantic results
    cell_semantic = bwareaopen(cell_semantic,300); % remove small object

    merge = cat(4, cell_ori, cell_eq, uint8(cell_semantic).*255, uint8(cell_semantic).*255);  % compare semantic result
    array2image(strcat(root_path, 'c1m2/',num2str(i_stack),'/img/compare_cell_semantic/'), merge);

    [filter_nuclei, nuclei_100] = generate_pseudo_nuclei(cell_semantic, 1, nuclei_volume_thr, 1, pixdim);
    merge = cat(4, uint8(cell_semantic).*255, uint8(filter_nuclei).*255, nuclei_100.*255);
    array2image(strcat(root_path, 'c1m2/',num2str(i_stack),'/img/compare_pseudo_nucleus/'), merge); 

    %% instance segment
    [cell_non, cell_isolate, cell_packed] = filter_connected_component(filter_nuclei, cell_semantic);

    % parameters 1:single cell volume
    single_volume = 4000; % mannual setting

    % parameters 2:the rules of link and volume
    link_volume_rules=[0,50,0.1;
                                50,100,0.1;
                                100,200,0.15;
                                200,300,0.25;
                                300,500,0.5;
                                500,700,3;
                                700,1500,4;
                                1500,6000,20;];

    [cell_isolate, cell_packed] = crop_merge(cell_isolate, cell_packed, filter_nuclei, ...
        single_volume, link_volume_rules, merge_basi_vol_thr, 'longest');

    % % visual
    merge = cat(4, uint8(logical(cell_isolate)).*255, uint8(decode_cell(cell_packed, 12)).*255);
    array2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/instacnce/'), merge);

    total_cells = cell_isolate;
    for i_m=1:max(cell_packed(:))
        total_cells(cell_packed==i_m) = max(total_cells(:))+1;
    end
    
    packed_properties = quantify_cell(cell_packed, pixdim);
    isolate_properties = quantify_cell(cell_isolate, pixdim);
    save(strcat(root_path,'c1m2/',num2str(i_stack),'/cell_total.mat'), "cell_non", "cell_isolate", ...
                                                             "cell_packed", "total_cells","packed_properties", "isolate_properties",'-v7.3')
end

