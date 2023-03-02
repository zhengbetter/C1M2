function [nuclei, nucle_100] = generate_pseudo_nuclei(cell_semantic, nuclei_r, nuclei_thr, delt_r, pixdim)

[cell_mat, n_c] = bwlabeln(cell_semantic);
stackSize = size(cell_mat);
bboxes = convert_bbox(table2array(regionprops3(cell_mat, 'BoundingBox')), stackSize,0);

nuclei = imerode(cell_semantic, defineCenterStructure(pixdim, nuclei_r));

for i=1:n_c
    fprintf(strcat("generate pseudo nuclei for %d connected component \n"), i);
    tmp_cell = cell_mat==i;
    tmp_nucle = tmp_cell & nuclei;
    nuclei(tmp_nucle)=0;
    tmp_cell = bbox2cell(tmp_cell, bboxes(i,:));
    tmp_nucle = bbox2cell(tmp_nucle, bboxes(i,:));
    
    tmp_nucle = erode_cell(tmp_nucle, tmp_cell, nuclei_thr, nuclei_r, delt_r, pixdim);

    nuclei = nuclei | chunk2stack(tmp_nucle, bboxes(i,:),stackSize);
end

nucle_100 = bwareaopen(nuclei, 100);
nucle_100 = find_stack_coordinate(nucle_100);
nucle_100 = imdilate(nucle_100, defineCenterStructure(pixdim, nuclei_r));

end


