function img = setCube(coordinate, img, k)
[i_x, i_y, i_z] = size(img);
for i = 1:size(coordinate,1)
    x = coordinate(i,1);
    y = coordinate(i,2);
    z = coordinate(i,3);
    
    xx = x-k:x+k;
    yy = y-k:y+k;
    zz = z-k:z+k;
    
    xx(xx<1) = 1;
    yy(yy<1) = 1;
    zz(zz<1) = 1;
    
    xx(xx>i_x) = i_x;
    yy(yy>i_y) = i_y;
    zz(zz>i_z) = i_z;
    
    [mex,mey,mez] = meshgrid(xx,yy,zz);
    mexx = reshape(mex,[],1);
    meyy = reshape(mey,[],1);
    mezz = reshape(mez,[],1);
    resu = [mexx,meyy,mezz];
    me = unique(resu,'rows');
    for j = 1:size(me)
        img(me(j,1),me(j,2),me(j,3)) = 255; % set the value of coordinate is 255
    end
end

end

