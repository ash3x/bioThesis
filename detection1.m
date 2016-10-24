% detection 1.0

% ribcage and abdomen inputs
function detection1(a, r)
%% pre processing
% Downsample and filter both signals
a = downsampleFilter(a);
r = downsampleFilter(r);

a = a*50;
r = r*50;

% PLA both signals
[slopeA, dxA, startsA] = PLA(a);
[slopeR, dxR, startsR] = PLA(r);

%% Plot PLA of both signals

% abdominal signal
subplot(211)
plot(a);
hold on; 
for i = 1:(length(slopeA)-1)
    line([startsA(i), startsA(i+1)], [a(startsA(i)), a(startsA(i+1))],...
        'Color', 'k');
    hold on;
    plot(startsA(i), a(startsA(i)), 'marker', 'x', 'Color', 'k');
    hold on;
    if (i > 1 && slopeA(i) < 0 && slopeA(i-1) > 0) 
        plot(startsA(i), a(startsA(i)), 'marker', 'o', 'Color', 'r');
        hold on;
    end
end
hold off;

%thorax signal
subplot(212)
plot(r);
hold on;
for i = 1:(length(slopeR)-1)
     line([startsR(i), startsR(i+1)], [r(startsR(i)), r(startsR(i+1))],...
        'Color', 'k');
    hold on;
    plot(startsR(i), r(startsR(i)), 'marker', 'x', 'Color', 'k');
    hold on;
    if (i > 1 && slopeR(i) < 0 && slopeR(i-1) > 0) 
        plot(startsR(i), r(startsR(i)), 'marker', 'o', 'Color', 'r');
        hold on;
    end
end
hold off;






