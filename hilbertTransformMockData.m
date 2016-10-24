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
subplot(311);
plot(t, r);
hold on 
plot(t, a);
hold off

%% Hilbert Transform and plot phase difference
Ha = hilbert(a);
Hr = hilbert(r);
haAngle = (angle(Ha));
hrAngle = (angle(Hr));
% subplot(312);
% plot(t, hrAngle);
% hold on;
% plot(t, haAngle);
% hold off;

subplot(312)
h = animatedline;
h.Color = 'red';
h2 = animatedline;
h2.Color = 'blue';
axis([0 60 -5 5])

subplot(313)
grid on;
h3 = animatedline;
axis([-4 4 -5 5])

for k = 1:length(t)
    addpoints(h,t(k),haAngle(k));
    addpoints(h2,t(k),hrAngle(k));
    %lissajous
    addpoints(h3,haAngle(k), hrAngle(k))
    drawnow
    pause(0.1)
end

%% Lissajous of Hilbert Transform


% plot(hrAngle, haAngle)

%% plot real time
% subplot(313)
% plot(t, t)
% axis([-4 4 -4 4])
% hold on
% for i = 1:240
%     sine waves
%     subplot(311)
%     plot(t(i), r(i))
%     hold on 
%     plot(t(i), a(i))
%     
%     hilbert transform sawtooth waves
%     subplot(312)
%     plot(t(i), hrAngle(i))
%     hold on 
%     plot(t(i), haAngle(i))
%     
%     lissajous
%     plot(hrAngle(i), haAngle(i), '+')
%     drawnow;
%     hold on 
%     pause(0.5)
% end


