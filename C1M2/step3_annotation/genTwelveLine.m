function [startPoints, endPoints] = genTwelveLine(minTotal, maxTotal)
    xmin = minTotal(1);
    ymin = minTotal(2);
    zmin = minTotal(3);
    
    xmax = maxTotal(1);
    ymax = maxTotal(2);
    zmax = maxTotal(3);
    
    rootPoint_1 = [xmin, ymin, zmin];
    rootPoint_2 = [xmax, ymax, zmin];
    rootPoint_3 = [xmin, ymax, zmax];
    rootPoint_4 = [xmax, ymin, zmax];
    rootPoints = [rootPoint_1;rootPoint_2;rootPoint_3;rootPoint_4];
    
    startPoints = zeros(12,3);
    endPoints = zeros(3,12);
      
    for i = 1:4
            startPoints((i-1)*3 +1, :) = rootPoints(i,:);
            startPoints((i-1)*3 +2, :) = rootPoints(i,:);
            startPoints((i-1)*3 +3, :) = rootPoints(i,:);
    end
    
    endPoints(:,1) = [xmax,ymin,zmin];
    endPoints(:,2) = [xmin,ymax,zmin];
    endPoints(:,3) = [xmin,ymin,zmax];
    
    endPoints(:,4) = [xmin,ymax,zmin];
    endPoints(:,5) = [xmax,ymin,zmin];
    endPoints(:,6) = [xmax,ymax,zmax];
    
    endPoints(:,7) = [xmax,ymax,zmax];
    endPoints(:,8) = [xmin,ymin,zmax];
    endPoints(:,9) = [xmin,ymax,zmin];
    
    endPoints(:,10) = [xmin,ymin,zmax];
    endPoints(:,11) = [xmax,ymax,zmax];
    endPoints(:,12) = [xmax,ymin,zmin];
    endPoints = endPoints';
end