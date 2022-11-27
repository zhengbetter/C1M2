function merge = decode_cell_2(cell_mat,channel_num)

%     b = mod(ind-1, 12)+1;
%     a1=cell_multi;
%     merge=cell(channel_num,1);
    n=max(cell_mat(:));
merge = [];
    for i=1:channel_num
        i
        a1=uint8(zeros(size(cell_mat)));
        for j=i:channel_num:n
            a1(cell_mat==j)=1;
        end
        merge= cat(4, merge, a1);
    end
    merge = merge.*255;
end