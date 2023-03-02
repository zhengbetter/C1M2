function Paths = listPath(GC, GCCenter)

    Paths = cell(size(GCCenter,1),size(GCCenter,1));
    for i =1:size(GCCenter,1)
        for j = i:size(GCCenter,1)
            Paths{i,j} = shortestpath(GC,GCCenter(i), GCCenter(j), 'Method', 'unweighted');
        end
    end


end