%% Constructs a polyphase filter from FIRFilter. 
% Downsampling factor is 25, which leaves the sampling rate at 4 Hz. 

Filt = FIRfilter;

M = 25; 
Num = Filt.Numerator;
FiltLength = length(Num);
Num = flipud(Num(:));

if (rem(FiltLength, M) ~= 0)
     nzeros = M - rem(FiltLength, M);
     Num = [zeros(nzeros,1); Num];  % Appending zeros
end

len = length(Num);
nrows = len / M;
PolyphaseFilt = flipud(reshape(Num, M, nrows).');

H = dsp.FIRDecimator(M, Num);

[abdo, thorax] = signals(DataEventHypnog_Mat);

thoraxFiltered = step(H,thorax);
abdoFiltered = step(H,abdo);

subplot(221);
t = linspace(0,length(thorax)/100,length(thorax));
plot(t, thorax);
axis([2580, 2600, -inf, +inf]);
title('Input Thorax Signal');
subplot(223);
tFilt = linspace(0,length(thoraxFiltered)/4,length(thoraxFiltered));
plot(tFilt, thoraxFiltered);
axis([2580, 2600, -inf, +inf]);
title('Output Thorax Signal Lowpass filtered and downsampled by 25');

subplot(222);
t = linspace(0,length(abdo)/100,length(abdo));
plot(t, abdo);
axis([2580, 2600, -inf, +inf]);
title('Input abdominal Signal');
subplot(224);
tFilt = linspace(0,length(abdoFiltered)/4,length(abdoFiltered));
plot(tFilt, abdoFiltered);
axis([2580, 2600, -inf, +inf]);
title('Output abdominal Signal Lowpass filtered and downsampled by 25');
