function array2image(filepath, img)
    cn = size(img,4);

    if cn ==1
        for iS = 1:size(img,3)
            filename = strcat(filepath, 'c1_',num2str(iS, '%04d'), '.tif');
            if(~exist(filepath, 'file'))
                mkdir(filepath); 
            end
            imwrite((img(:,:,iS)), filename);
        end
        
    else
            
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
