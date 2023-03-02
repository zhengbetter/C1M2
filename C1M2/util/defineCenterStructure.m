function seSoma = defineCenterStructure(pixdim, rSomaPreliminary)
    %--- create structuring element
    %- radius of sphere
    dim = pixdim;
    sesz = rSomaPreliminary ./ dim;
    %--- center of the sphere
    secr = round(sesz) + 1;
    %--- size of bounding box
    sesz = 2 * round(sesz) + 1;
    %--- distance from center
    ne = zeros(sesz);
    for i=1:size(ne,1)
        for j=1:size(ne,2)
            for k=1:size(ne,3)
                ne(i,j,k) = sum(([i j k] .* dim - secr .* dim).^2).^.5;
            end
        end
    end
    %--- voxel within requested radius from center
    ne(ne>rSomaPreliminary) = 0;
    ne(secr(1),secr(2),secr(3)) = 1;
    ne = logical(ne);
    %--- visualize the spherical structuring element
    % show_cells_3D(ne,hdr,[],[],10);
    %---
    seSoma = strel(ne);
end