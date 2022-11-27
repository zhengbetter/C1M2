clear
clc

root_path = '/data2/zhenghao/cell_segment/dataset/standard/GTM/';
thr = 0.5;
TP = 0;
FN = 0; 

predict_num = 0;
gt_num = 0;

for stack_num = [1]
    dataset = load(strcat(root_path,'gt/gt_',  num2str(stack_num),'.mat'));
    dataset = dataset.data_set;
    
    segment_results = load(strcat(root_path,  '/c1m2/',num2str(stack_num),'/cellMat.mat'));
    segment_results = segment_results.total_cells;
    
    for i = 1:size(dataset,1)
        i_bboxes = dataset{i,1};
        i_semantic = dataset{i,3};
        i_gt = dataset{i,4};
    
        tmp_mat = remove_gap(bbox2cell(segment_results, i_bboxes) .* double(logical(i_semantic)));
        
        gt_num = gt_num + max(i_gt(:));
        predict_num = predict_num + max(tmp_mat(:));
    
        for j=1:max(i_gt(:))
            j_cell = i_gt == j;
            
            IoU = zeros(max(tmp_mat(:)),1);
            for k=1:max(tmp_mat(:))
                IoU(k,1) = sum((j_cell & tmp_mat==k),'all') / sum((j_cell | tmp_mat==k), 'all');
            end
    
            if max(IoU) > thr
                TP = TP + 1;
            else
                FN = FN + 1;
            end
        end
    end
end

FP = predict_num - TP;
AP = TP/(TP+FP+FN)


