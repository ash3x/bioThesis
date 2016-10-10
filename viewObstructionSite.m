% browse through abdominal and thorax signals at the event of an obstruction

function viewObstructionSite(sigNum)
    
    M = 25;
    Fs = 4;
    
    % Assign variables to data in base workspace
    abdominalSignals = evalin('base','abdominalSignals');
    thoraxSignals = evalin('base','thoraxSignals');
    obstrSignals = evalin('base','obstrSignals');
    vectorLengths = evalin('base','vectorLengths');
    
    event = obstrSignals(:,sigNum);
    event = event(1:vectorLengths(sigNum));
    abdo = abdominalSignals(:,sigNum);
    abdo = abdo(1:vectorLengths(sigNum));
    thorax = thoraxSignals(:,sigNum);
    thorax = thorax(1:vectorLengths(sigNum));

    event = downsample(event, M);
    abdoFiltered = downsampleFilter(abdo);
    thoraxFiltered = downsampleFilter(thorax);

    startIndex = [];
    endIndex = [];
    obstrFound = 0;
    j = 1;
    
    for i = 1:length(event)
        if(event(i) && ~obstrFound)
            startIndex(j) = i - 480; % go back by 2 minutes
            obstrFound = 1;
        end

        if(~event(i) && obstrFound)
            endIndex(j) = i + 480; % go forward by 2 minutes
            obstrFound = 0;
            j = j + 1;
        end
    end
    
    if isempty (startIndex)
        disp('No obstructions found')
        return;
    end
    
    t = linspace(0,length(abdoFiltered)/Fs,length(abdoFiltered));
%     plot(t, event);
    obstrIndex = 1;
    f = figure;
    while 1
        plot(t, abdoFiltered);
        hold on
        plot(t, thoraxFiltered);
        % Specify start and endpoints of obstruction
        line([(startIndex(obstrIndex)/Fs + 120)...
            (startIndex(obstrIndex)/Fs + 120)], get(gca, 'ylim'), ...
            'Color', 'g');
        line([(endIndex(obstrIndex)/Fs - 120)...
            (endIndex(obstrIndex)/Fs - 120)], get(gca, 'ylim'), ...
            'Color', 'g');
        axis([startIndex(obstrIndex)/Fs,...
            endIndex(obstrIndex)/Fs, -inf, +inf]);
        title(['Abdominal Signal vs Thorax Signal - obstruction ', ...
            int2str(obstrIndex)]);
        xlabel('Time - seconds');
        
        hold off
        legend('abdominal band', 'thoracic band')
        
        while 1
            w = waitforbuttonpress;
            if w == 1
                obstrIndex = obstrIndex + 1;
                if obstrIndex > length(startIndex)
                    obstrIndex = 1;
                end
                disp(strcat('obstruction between ', int2str(...
                    (startIndex(obstrIndex) + 480)/Fs), 's and ', ...
                    int2str((endIndex(obstrIndex) - 480)/Fs), 's'));
                break
            else 
                continue
            end
        end
        
    end
end

