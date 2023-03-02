function img = setEdge(P1,P2,img,k)

for i = 1:size(P1,1)
    % Given two endpoints, produces a series of points that form a straight line at these two endpoints

    p1 = P1(i,:);
    
    p2 = P2(i,:);
    xx = round(linspace(p1(1),p2(1),50))';
    yy = round(linspace(p1(2),p2(2),50))';
    zz = round(linspace(p1(3),p2(3),50))';
    resu = [xx,yy,zz]; 
    
    img = setCube(resu, img, k); 
    
end
end


