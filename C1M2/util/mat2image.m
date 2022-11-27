function mat2image(filepath, img, channelsName, mode)
    % if mode=0，save only merge image
    % if mode=1，save only single channel images 
    % if mode=2, save single channel images and merge image

    cn = size(img,4);

    if cn ==1
        for iS = 1:size(img,3)
            filename = strcat(filepath, 'c3_',num2str(iS, '%04d'), '.tif');
            if(~exist(filepath, 'file'))
                mkdir(filepath); 
            end
            imwrite((img(:,:,iS)), filename);
        end
        
    else
        if mode == 1 || mode==2
            for iC = 1:cn 
                tmpPath = strcat(filepath, channelsName(iC), '/');
                if(~exist(tmpPath, 'file'))
                    mkdir(tmpPath); 
                end

                for iS = 1:size(img,3)
                    filename = strcat(tmpPath, num2str(iS, '%04d'), '.tif');
                    imwrite(squeeze(img(:,:,iS, iC)),filename);
                end
            end
        end
        
        if mode == 0 || mode == 2
            
            tmpPath = strcat(filepath, 'merge/');
            if(~exist(tmpPath, 'file'))
                mkdir(tmpPath); 
            end
            
            for iC = 1:cn  
                for iS = 1:size(img,3)
                    filename = strcat(tmpPath, 'c',num2str(iC),'_',num2str(iS, '%04d'),'.tif');
                    imwrite(squeeze(img(:,:,iS,iC)),filename);
                end
            end
        end
    end
           

end
