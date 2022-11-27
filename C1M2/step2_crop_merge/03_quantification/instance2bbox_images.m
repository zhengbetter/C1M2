function [cell_mat, instance_bboxes, instance_cell ,s] = instance2bbox_images(cell_mat, pixdim)
    
    instance_bboxes = convert_bbox(table2array(regionprops3(cell_mat, 'BoundingBox')), size(cell_mat), 0);
    % filter by bbox
    ind = find((instance_bboxes(:,6)-instance_bboxes(:,3)) < 10);
    instance_bboxes(ind,:)=[];
    for i=1:size(ind,1)
        cell_mat(cell_mat==ind(i))=0;
    end
    cell_mat = remove_gap(cell_mat);

    % compute property
    instance_cell= table2cell(regionprops3(cell_mat, 'Image')); 
    % align cell_bboxes
    instance_bboxes = align_bbox_cell(instance_bboxes, instance_cell);

    % parameters
    s = regionprops3(cell_mat,"Volume", "Extent", "PrincipalAxisLength",...
        "Orientation", "ConvexVolume", "Solidity", "SurfaceArea", "Centroid");
    
    scale = pixdim(1) .* pixdim(2) .* pixdim(3);
    s.Volume = s.Volume .* scale;
    s.Centroid = s.Centroid.*pixdim;
    s.ConvexVolume = s.ConvexVolume .* scale;
    s.SurfaceArea = s.SurfaceArea.* scale;
    s.PrincipalAxisLength = s.PrincipalAxisLength .* scale;
end