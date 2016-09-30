
%PowerSpectralDensity averaging
abdo = abdominalSignals(:,6);
% for i = 1:length(vectorLengths)
%     newAbdo = abdominalSignals(:,i);
%     newAbdo = newAbdo(1:vectorLengths(i));
%     abdo = [abdo; newAbdo];
% end 
% abdo = abdo(1:12000);

Fs = 100;
averageFreqs = [];
for signalIndex = 1:length(vectorLengths)
    abdo = abdominalSignals(:,signalIndex);
    %% take the power spectral estimate every 0.5 hours (180000 samples)
    for i = 1:floor(length(abdo)/180000)
        dataSegment = abdo(((i-1)*180000 + 1):(i*180000));
        freq = 0:Fs/length(dataSegment):Fs/2;
        dB = powerSpectralDensity(dataSegment, Fs);
        threshold = mean(dB)/3;
        % Find the frequencies whose power spectral estimates are higher than 
        % 33 dB in attenuation - agreed attenuation difference
        importantFreq = [];
        k = 1;
        for j = 1:length(dB)
            if dB(j) > threshold
                importantFreq(k) = freq(j);
                k = k+1;
            end
        end

        % Find the upper and lower bound - range of frequencies
        if length(importantFreq) > 0
            lower(i) = importantFreq(1);
            upper(i) = importantFreq(length(importantFreq));
        end
    end

    %% last segment of data 
    dataSegment = abdo((i*180000 + 1):length(abdo));
    freq = 0:Fs/length(dataSegment):Fs/2;
    dB = powerSpectralDensity(dataSegment, Fs);
    threshold = mean(dB)/3;
    % Find the frequencies whose power spectral estimates are higher than 
    % 35 dB in attenuation
    importantFreq = [];
    k = 1;
    for j = 1:length(dB)
        if dB(j) > threshold
            importantFreq(k) = freq(j);
            k = k+1;
        end
    end

    % Find the upper and lower bound - range of frequencies
    if ~isempty(importantFreq)
        lower(i) = importantFreq(1);
        upper(i) = importantFreq(length(importantFreq));
    end


    %% Average the frequency at which signal information no longer becomes
    % important
    disp(['mean of the upper bound for signal ' num2str(signalIndex) ':'])
    averageFreqs(signalIndex) = mean(upper)
end

