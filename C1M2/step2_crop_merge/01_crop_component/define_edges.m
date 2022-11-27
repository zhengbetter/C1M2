function E = define_edges(UN, neighbors)

    E = [];
    ne2 = zeros(2,3);
    for i=1:length(UN)
        if length(UN{i})>2
            UT = UN{i};
            nUT = length(UT);
            nTuple = nUT*(nUT-1)/2;
            ne = zeros(nTuple,3);
            c = 0;
            for j=1:nUT-1
                for k=j+1:nUT
                    c=c+1;
                    ne(c,:) = [UT(j), UT(k), neighbors(UT(j),UT(k))];
                end
            end
            %--- throw away tuples, which are not anymore touching after the merging operation
            if any(ne(:,3)==0)
                disp(ne)
                ne(ne(:,3)==0,:) = [];
            end
            %--- disambiguate, only if more then two edges
            if size(ne,1)<=2
                UE = ne(:,1:2)';
            else

                [~,idx] = max(ne(:,3));
                UE = ne(idx,1:2);
                for j=1:nUT-2
                    %--- test the left end
                    idl = any(UE(1)==ne(:,1:2), 2);
                    for k=2:length(UE)
                        idl = idl & ~any(UE(k)==ne(:,1:2), 2);
                    end
                    idx1 = find(idl);
                    [~,idx2] = max(ne(idx1,3));
                    ne2(1,:) = ne(idx1(idx2),:);
                    %--- test the right end
                    idl = any(UE(end)==ne(:,1:2), 2);
                    for k=1:length(UE)-1
                        idl = idl & ~any(UE(k)==ne(:,1:2), 2);
                    end
                    idx1 = find(idl);
                    [~,idx2] = max(ne(idx1,3));
                    ne2(2,:) = ne(idx1(idx2),:);
                    if ne2(1,3) > ne2(2,3)
                        UE = [    ne2(1, find(~ismember(ne2(1,1:2),UE))), UE];
                    else
                        UE = [UE, ne2(2, find(~ismember(ne2(2,1:2),UE)))    ];
                    end
                end
                UE = [UE(1:end-1); UE(2:end)];
            end
            E = [E, UE];
        else
            E = [E, UN{i}];
        end
    end
    %---
    E = unique(sort(E)','rows');
end