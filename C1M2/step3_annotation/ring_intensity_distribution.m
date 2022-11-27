function ring_intensity_distribution(intensity_ring, cls)    

    c=[ 0 0.4470 0.7410;
        0.4660 0.6740 0.1880;
        0.9290 0.6940 0.1250;
        0.6350 0.0780 0.1840];
    if ~isempty(cls)
        figure;
        for i=1:size(intensity_ring,1)
            if cls(i) >= 0
                plot(intensity_ring(i,:),'Color', c(cls(i)+1,:))
            end
            hold on
        end
        xlim tight
        ylim tight
        ylabel('Intensity Value')
        xlabel('Ring Step')
        hold off
        
    else
        figure;
        for i=1:size(intensity_ring,1)
            plot(intensity_ring(i,:), 'Color',[0.3010, 0.7450, 0.9330])
            hold on
        end
        
        xlim tight
        ylim tight
        ylabel('Intensity Value')
        xlabel('Ring Step')
        hold off
    end
end