A = 1; %magnitude
tp = 2^12; %number of time steps
omega1 = 240; %carrier freq
omega2 = 10; %modulation freq
gamma = pi/7; %phase offset
beta = 5; %modulation amplitude
t = 0:2*pi/tp:2*pi*(1-1/tp); %time vector
x = A*cos(omega1*t+gamma+beta*sin(omega2*t));
%phase modulated signal
plot(t(1:round(length(x)/omega2)),x(1:round(length(x)/omega2))) %plot modulated signal
xlim([0 t(round(length(x)/omega2))])
xlabel('time (s)')
ylabel('magnitude')