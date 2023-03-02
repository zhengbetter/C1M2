function [GC, separatePaths, separateWeights] = separate_graph(GC, dPaths, mode)

    separatePaths = {};
    separateWeights =[];

    if strcmp('shortest', mode)
    
        for i = 1:size(dPaths,1)
            [GC, temPath, tmpWeight] = separate_two_seednode_shortest(GC, dPaths(i,:));
    
            separatePaths = [separatePaths; temPath];
            separateWeights = [separateWeights; tmpWeight];
        end
    
    elseif strcmp('longest', mode)

        for i = 1:size(dPaths,1)
            
            [GC, temPath, tmpWeight] = separate_two_seednode_longest(GC, dPaths(i,:));

            separatePaths = [separatePaths; temPath];
            separateWeights = [separateWeights; tmpWeight];
        end
    else
        error('mode not define');
    end

end