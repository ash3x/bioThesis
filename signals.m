%% Extract abdominal and thorax RIP signals from given data
function [abdo, thorax] = signals(DataEventHypnog_Mat)

abdo = DataEventHypnog_Mat(:,3);
thorax = DataEventHypnog_Mat(:,2);
flow = DataEventHypnog_Mat(:,4);
% 
% plot(abdo)
% hold on
% Fs = 10
% fc = 1;
% Wn = (2/Fs)*fc;
% b = fir1(20,Wn,'low',kaiser(21,3));
% y = filter(b,1,abdo);
% 
% plot(y);
% hold off


% plot(thorax)
% hold off

