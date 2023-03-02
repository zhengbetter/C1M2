function dPaths = verifyLink(GC,seedNodes)

    Paths = listPath(GC, seedNodes);

    dPaths = directConnect(Paths, seedNodes);
    
    
end