%% Implements a moving average filter

[abdo, thorax] = signals(DataEventHypnog_Mat);

abdoFiltered = smooth(abdo);

%% plot
subplot(211);
t = linspace(0,length(abdo)/100,length(abdo));
plot(t, abdo);
% axis([2580, 2600, -inf, +inf]);
title('Input abdominal Signal');

subplot(212);
tFilt = linspace(0,length(abdoFiltered)/100,length(abdoFiltered));
plot(tFilt, abdoFiltered);
% axis([2580, 2600, -inf, +inf]);
title('Output abdominal Signal with applied moving average filter');