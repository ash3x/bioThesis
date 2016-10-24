%% Piecewise Linear Approxmimation

tolerance = 0.1;
s = 3;

%outputs
% dx; %array with horizontal projections of lengths of straight lines
% slope; % array containing slopes of straight line segments

% begin
start = 1;
stop = 1;
idx = 1;
step = s; % multiple of s
error = 0
peak = [];
peakIndex = 1;

f = downsampleFilter(abdominalSignals(:,6));

f = f(1:241);
f = f*100;

plot(f);
hold on;
while start < length(f)
    error = 0;
    current_step = 0;
    while (error < tolerance) && (stop < length(f))
        step = s;
        current_step = current_step + step;
        stop = stop + step;
        m = (f(stop) - f(start))/(stop - start);

        % maximal error check
        j = 1;
        errArray = [];
        for i = start:stop
            errArray(j) = abs((f(i) - m * (i - start) - f(start)) / sqrt(m^2 + 1));
            j = j + 1;
        end
        error = max(errArray)
    end
    
    disp('error bigger')
    if ~exist('dx', 'var') && ~exist('slope', 'var')
        dx(1) = stop - start;
        slope(1) = (f(stop) - f(start))/dx(idx);
    else
        dx(length(dx) + 1) = stop - start;
        slope(length(slope) + 1) = (f(stop) - f(start))/dx(idx);
        
    end
    
    if length(slope) > 1
        if slope(length(slope)) < 0 && slope(length(slope)-1) > 0
            plot(start, f(start), 'marker', 'o')
            peak(peakIndex) = start;
            peakIndex = peakIndex + 1;
        end
    end
    
    line([start, stop], [f(start), f(stop)], 'Color', 'k');
    plot(start, f(start), 'marker', 'x', 'Color', 'k')
    hold on;
    idx = idx + 1;
    start 
    stop
    start = stop;
    
end


hold off;

period = [];
p = 1;

for i = 2:length(peak)
    period(p) = peak(i)-peak(i-1);
    p = p + 1;
end

dx
slope

period
        
