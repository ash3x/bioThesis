    t = linspace(0, 60, 6000);

%% Generate Ribcage and abdominal Signals
a1 = 1;
a2 = 0.8;

r = a1*sin(2*pi*0.3*t);
a = a2*sin(2*pi*0.3*t + linspace(0,pi,6000));
r = awgn(r,20);
a = awgn(a,20);

%% Filter
r = downsampleFilter(r);
a = downsampleFilter(a);

t = linspace(0, 60, 240);
plot(t, r);
hold on 
plot(t, a);
hold off

%% Hilbert Transform and plot phase difference
Ha = hilbert(a);
Hr = hilbert(r);
sigphase = (unwrap(angle(Hr)))';
phase_rad = unwrap(angle(Ha) - angle(Hr));
figure
plot(t, phase_rad)
