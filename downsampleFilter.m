% Downsamples the data by a factor of 4 and then filters. 

function sigFiltered = downsampleFilter(signal)
%% downsample by 25 and filter. Sampling Frequency becomes 4.
    M = 25;
    sigDecimated = downsample(signal,M);

    %% least square algorithm for FIR filtering;
    
    % 8 order filter with the transition band between 0.4 and 0.5 of 
    % the nyquist frequency - the nyquist frequencvy being 2 after
    % downsampling
    
    % Weighting factor of 100 (stopband weight higher than the passband 
    % weight
    % This weighting factor is use because it is critical that the magnitude 
    % in the stopband is flat and close to zero.
    
    fir = firls(8,[0 0.35 0.45 1],[1 1 0 0],[1 100]);
    sigFiltered = filter(fir, 1, sigDecimated);
    
    % Take the derivative of the signal
%     sigFiltered = diff(sigFiltered);
%% plot
%     subplot(211);
%     t = linspace(0,length(signal)/100,length(signal));
%     plot(t, signal);
%     axis([2580, 2600, -inf, +inf]);
%     title('Input Abdominal Signal');
%     xlabel('Time - seconds');
%     subplot(212);
%     tFilt = linspace(0,length(sigFiltered)/4,length(sigFiltered));
%     plot(tFilt, sigFiltered);
%     axis([2580, 2600, -inf, +inf]);
%     title('Output Lowpass filtered and downsampled by 25');
%     xlabel('Time - seconds');
end
