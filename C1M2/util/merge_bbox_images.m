function [merge_bboxes, merge_cell_images] = merge_bbox_images(bboxes_1,bboxes_2, cell_imgs_1, cell_imgs_2)
    merge_bboxes = bboxes_1;
    merge_cell_images = cell_imgs_1;
    
%     volume_cell_1 = zeros(size(cell_imgs_1,1),1);
%     volume_cell_2 = zeros(size(cell_imgs_2,1),1);
%     for i=1:size(cell_imgs_1,1)
%         volume_cell_1(i) = sum(cell_imgs_1{i,1}, 'all');
%     end
% 
%     for i=1:size(cell_imgs_2,1)
%         volume_cell_2(i) = sum(cell_imgs_2{i,1}, 'all');
%     end

    for i=1:size(bboxes_2,1)
        tmp_bboxes_2 = bboxes_2(i,:);
%         volume_r = max(volume_cell_2(i) ./ volume_cell_1);
        delt = sum(sqrt((bboxes_1 - tmp_bboxes_2).^2),2);
    
        if min(delt) <100
%             [~, ind] =min(delt);
%             tmp_my_bboxes = bboxes_1(ind,:);
%             merge_bboxes(ind,:) = [min([tmp_my_bboxes(1:3);tmp_bboxes_2(1:3)], [], 1), ...
%                                             max([tmp_my_bboxes(4:6);tmp_bboxes_2(4:6)], [],1)];
        else
            merge_bboxes = [merge_bboxes;tmp_bboxes_2];
            merge_cell_images = [merge_cell_images; cell_imgs_2{i,1}];
        end
    
    end

end