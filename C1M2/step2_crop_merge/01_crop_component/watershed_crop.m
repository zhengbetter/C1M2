function [ML, MS, MLn] = watershed_crop(BW, conn)
 
    MD = bwdist(~BW);
    MI = -MD;
    ML = watershed(MI, conn);
  
    ML(~BW) = 0;
    MLn = double(max(ML(:)));

    MS = BW;
    MS(ML>0) = 0;
end