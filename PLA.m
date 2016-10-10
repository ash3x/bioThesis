%% Piecewise Linear Approxmimation

tolerance = 3;
s = 5;

%outputs
% dx; %array with horizontal projections of lengths of straight lines
% slope; % array containing slopes of straight line segments

% begin
start = 1;
stop = 1;
idx = 1;
step = s; % multiple of s
error = 0

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
        for i = start:stop
            errArray(i) = abs((f(i) - m * (i - start) - f(start)) / sqrt(m^2 + 1));
        end
        error = max(errArray)
    end
    
    if ~exist('dx', 'var') && ~exist('slope', 'var')
        dx(1) = stop - start;
        slope(1) = (f(stop) - f(start))/dx(idx);
    else
        dx(length(dx) + 1) = stop - start;
        slope(length(slope) + 1) = (f(stop) - f(start))/dx(idx);
        
    end
    
    line([start, stop], [f(start), f(stop)], 'Color', 'g');
    plot(start, f(start), 'marker', '+')
    hold on;
    idx = idx + 1;
    start 
    stop
    start = stop;
    
end
hold off;


dx
slope

        
