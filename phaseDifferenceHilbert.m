% A function to display visually the phase difference obtained from the 
% Hilbert transform between abdominal and thoracic signals. 
% The data is first filtered then processed. 
% Data is displayed 2 minutes before and after the obstruction.


function phaseDifferenceHilbert(sigNum, obstrNum)
    Fs = 4;
    [abdo, thorax, obstr] = getFilteredSignals(sigNum);
    
    % Plot the phase difference of the abdominal and thoracic bands.
    
    [startSample, endSample] = getObstructionSegment(obstr, obstrNum)
    
    % Go back from the obstruction by 2 minutes and forward from the
    % obstruction by 2 minutes
    if (endSample + 480) > length(obstr)
        abdoLissajous = abdo((startSample-480):length(obstr));
        thoraxLissajous = thorax((startSample-480):length(obstr));
        tLissajous = linspace((startSample-480)/Fs,length(obstr)/Fs,...
        (endSample-startSample + (length(obstr) - endSample) + 480 + 1));
        disp('1')
        
    elseif (startSample - 480) < 0
        abdoLissajous = abdo(0:(endSample+480));
        thoraxLissajous = thorax(0:(endSample+480));
        tLissajous = linspace(0,(endSample+480)/Fs,...
        (endSample));
        disp('2')
    
    else
        abdoLissajous = abdo((startSample-480):(endSample+480));
        thoraxLissajous = thorax((startSample-480):(endSample+480));
        tLissajous = linspace((startSample-480)/Fs,(endSample+480)/Fs,...
        (endSample-startSample + 480 + 480 + 1));
    
    end
    t = linspace(0,length(abdo)/Fs,length(abdo));
    disp('3')   
    
%     end    
    
    Ha = hilbert(abdo);
    Ht = hilbert(thorax);
    phase_rad = unwrap(angle(Ha) - angle(Ht));
    
    %% plot Hilbert transform of data
    figure
    subplot(311)
    plot(t, angle(Ha))
    hold on; 
    plot(t, angle(Ht))
    title('Hilbert Transform of Obstruction');
    xlabel('Time - seconds');
    legend('abdominal band', 'thoracic band');
    line([(startSample)/Fs...
            (startSample)/Fs], get(gca, 'ylim'), ...
            'Color', 'g');
    line([(endSample)/Fs...
        (endSample)/Fs], get(gca, 'ylim'), ...
        'Color', 'g');
    %%%%%%%
    axis([startSample/Fs - 120,...
        endSample/Fs + 120, -inf, +inf]);
    %%%%%%%
    hold off;
    
    %% Plot abdominal and thorax signals as a reference
    subplot(312)
    plot(t, abdo)
    hold on 
    plot(t, thorax)
    title('Abdominal vs Thorax signals');
    xlabel('Time - seconds');
    legend('abdominal band', 'thoracic band');
    line([(startSample)/Fs...
        (startSample)/Fs], get(gca, 'ylim'), ...
        'Color', 'g');
    line([(endSample)/Fs...
        (endSample)/Fs], get(gca, 'ylim'), ...
        'Color', 'g');
    %%%%%%%
    axis([startSample/Fs - 120,...
        endSample/Fs + 120, -inf, +inf]);
    %%%%%%%
    hold off
    
    %% Plot Lissajous Figure
    
    subplot(313)
    HaLissajous = hilbert(abdoLissajous);
    HtLissajous = hilbert(thoraxLissajous);
    plot(angle(HaLissajous), angle(HtLissajous));
    title('Lissajous figure after hilbert transform');
    
    
end
    
    
    
function [startSample, endSample] = ...
    getObstructionSegment(obstrSig, obstrNum)
    startSampleIndex = [];
    endSampleIndex = [];
    
    j = 1;
    obstrFound = 0;
    length(obstrSig)
    for i = 1:length(obstrSig)
        if(obstrSig(i) && ~obstrFound)
            startSampleIndex(j) = i; % go back by 2 minutes
            obstrFound = 1;
        end

        if(~obstrSig(i) && obstrFound)
            endSampleIndex(j) = i; % go forward by 2 minutes
            obstrFound = 0;
            j = j + 1;
        end
    end
    
    if obstrNum > length(startSampleIndex)
        disp(['There are only ' int2str(length(startSampleIndex)) ...
            ' in this patients record']);
        return
    end
    
    startSample = startSampleIndex(obstrNum);
    endSample = endSampleIndex(obstrNum);
end

        
        
        