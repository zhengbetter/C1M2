function [sN, eN] = array4edge(connectPath)
    sN = connectPath;
    eN = sN;
    sN(end) = [];
    eN(1) = [];
end