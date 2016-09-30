%% Breath detection algorithm


% retrieve data
abdo = abdominalSignals(:,2);
thorax = thoraxSignals(:,2);
abdo = abdo(1:vectorLengths(2));
thorax = thorax(1:vectorLengths(2));
abdoFiltered = downsampleFilter(abdo);
thoraxFiltered = downsampleFilter(thorax);


Habdo = hilbert(abdoFiltered);
Hthorax = hilbert(thoraxFiltered);
sigphase = (unwrap(angle(Hthorax)))';
phase_rad = unwrap(angle(Habdo) - angle(Hthorax));
plot(phase_rad)


