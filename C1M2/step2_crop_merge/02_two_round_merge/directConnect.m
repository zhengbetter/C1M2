function direct = directConnect(Paths, GCCenter)
direct = {};
n = 1;
    for i =1:size(Paths,1)
        for j = i:size(Paths,1)
            if ~(i ==j)
                p = Paths{i,j};
                if isDirectConnect(p, GCCenter) 
                    direct{n,1} = [p(1), p(end)];
                    n = n+1;
                end
            end
        end
    end
    direct = cell2mat(direct);

    

end