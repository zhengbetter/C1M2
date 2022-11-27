function [U, Ul, Uind] = remove_voxel_01(U,Ul, Uind)
    %% Check and remove neighborhood tuples for voxel not touching any area or touching only one area (both cases should be very rare)
    idx = find(Ul==0);
    if ~isempty(idx)
        U(idx) = [];
        Uind(idx) = [];
        Ul(idx) = [];
    end
    idx = find(Ul==1);
    if ~isempty(idx)
        U(idx) = [];
        Uind(idx) = [];
        Ul(idx) = [];
    end
    %--- sort U by length of neighborhood
    [Ul, I] = sort(Ul);
    U = U(I);
    Uind = Uind(I);
end