clear
clc

% This script for CD11c cells

root_path = '/root_path/';
pixdim = [0.5, 0.5, 0.25]; % the resolution of x, y, and z, respectively
merge_basi_vol_thr = 500;  % the threshold of block volume

for i_stack = [1,2]

        %% semantic
        % nucleus segment
        nucleus_ori =image2array(strcat(root_path,  'example/', num2str(i_stack), '/nucleus/'));

        fprintf('start enchance nuclei\n')
        nucleus_eq = enhance_image(nucleus_ori);

        fprintf('start segment nuclei\n')
        nuclei_segment = nucleus_semantic_segment(nucleus_eq);

        % cell segment
        cell_ori = image2array(strcat(root_path, 'example/', num2str(i_stack), '/cell/'));

        fprintf('start enhance cells\n')
        cell_eq = enhance_image(cell_ori);
        array2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/cell_enhance/'), cell_eq)

        fprintf('start semantic segment cells\n')
        cell_semantic = cell_semantic_segment(cat(4, nucleus_ori, cell_eq), 65, 85, pixdim);
        cell_semantic = bwareaopen(cell_semantic, 6000); % remove small object

        array2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/cell_semantic/'), uint8(cell_semantic).*255);
        merge = cat(4, cell_ori, cell_eq, uint8(cell_semantic).*255); % compare cell semantic segment results
        array2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/compare_cell_semantic/'), merge);

        % filter nuclei
        filter_nuclei = bwareaopen(nuclei_segment & cell_semantic, 50);
        array2image(strcat(root_path, 'c1m2/', num2str(i_stack),'/img/nucleus_segment/'), uint8(filter_nuclei).*255);

        % compare nucleus segment results
        merge = cat(4, nucleus_ori, nucleus_eq, uint8(nuclei_segment).*255, uint8(filter_nuclei).*255);
        array2image(strcat(root_path, 'c1m2/', num2str(i_stack), '/img/compare_nucleus/'), merge);

        %% instance segment
        fprintf('start filter connected components\n')
        [cell_non, cell_isolate, cell_packed] = filter_connected_component(filter_nuclei, cell_semantic);

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

        [cell_isolate, cell_packed] = crop_merge(cell_isolate, cell_packed, filter_nuclei, ...
            single_volume, link_volume_rules, merge_basi_vol_thr, 'longest');
        
        merge = cat(4, uint8(logical(cell_isolate)).*255, uint8(decode_cell(cell_packed, 12)).*255);
        array2image(strcat(root_path, 'c1m2/', num2str(i_stack),'/instacnce/'), merge);

        total_cells = cell_isolate;
        for i_m=1:max(cell_packed(:))
            total_cells(cell_packed==i_m) = max(total_cells(:))+1;
        end
        
        packed_properties = quantify_cell(cell_packed, pixdim);
        isolate_properties = quantify_cell(cell_isolate, pixdim);
        
        save(strcat(root_path,'c1m2/', num2str(i_stack), '/cell_total.mat'), "cell_non", "cell_isolate", ...
                "cell_packed", "total_cells", "packed_properties", "isolate_properties", '-v7.3')

end
