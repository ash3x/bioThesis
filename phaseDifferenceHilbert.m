
function phaseDifferenceHilbert(sigNum, obstrNum)
    Fs = 4;
    [abdo, thorax, obstr] = getFilteredSignals(sigNum);
    
    % Plot the phase difference of the abdominal and thoracic bands.
    
    [startSample, endSample] = getObstructionSegment(obstr, obstrNum)
    abdo = abdo(startSample:endSample);
    thorax = thorax(startSample:endSample);
    t = linspace(startSample/Fs,endSample/Fs,(endSample-startSample + 1));
    Ha = hilbert(abdo);
    Ht = hilbert(thorax);
    phase_rad = unwrap(angle(Ha) - angle(Ht));
    plot(t, phase_rad)
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
            startSampleIndex(j) = i - 480; % go back by 2 minutes
            obstrFound = 1;
        end

        if(~obstrSig(i) && obstrFound)
            endSampleIndex(j) = i + 480; % go forward by 2 minutes
            if endSampleIndex(j) > length(obstrSig);
                endSampleIndex(j) = length(obstrSig);
            end
            obstrFound = 0;
            j = j + 1;
        end
    end
    
    if obstrNum > length(startSampleIndex)
        disp('There are only ', int2str(length(startSampleIndex)), ...
            'in this patients record');
        return
    end
    
    startSample = startSampleIndex(obstrNum);
    endSample = endSampleIndex(obstrNum);
end

        
        
        