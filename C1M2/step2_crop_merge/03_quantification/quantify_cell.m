function properties = quantify_cell(cell_mat, pixdim)
    
     % parameters
    properties = regionprops3(cell_mat,"Volume", "Extent", "PrincipalAxisLength",...
        "Orientation", "ConvexVolume", "Solidity", "SurfaceArea", "Centroid");
    
    scale = pixdim(1) .* pixdim(2) .* pixdim(3);
    properties.Volume = properties.Volume .* scale;
    properties.Centroid = properties.Centroid.*pixdim;
    properties.ConvexVolume = properties.ConvexVolume .* scale;
    properties.SurfaceArea = properties.SurfaceArea.* scale;
    properties.PrincipalAxisLength = properties.PrincipalAxisLength .* scale;
end