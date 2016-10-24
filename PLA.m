%% Piecewise Linear Approxmimation

% slope -> slope of the straights
% dx -> length of the straights
% starts -> x coordinate of the start of each straight 
function [slope, dx, starts] = PLA(inputSignal)
tolerance = 0.01;
s = 2; % Minimum length of a line segment

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
% 
% inputSignal = downsampleFilter(inputSignal);
% 
% f = f(1:238);
% f = f*100;


length(inputSignal)
m = mod((length(inputSignal) + 1), s);
if m ~= 0
    f = inputSignal(1:length(inputSignal) - s + 1);
else
    f = inputSignal;
end

% length(f)

% plot(f);
% hold on;
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
        error = max(errArray);
    end
    
    if ~exist('dx', 'var') && ~exist('slope', 'var')
        dx(1) = stop - start;
        slope(1) = (f(stop) - f(start))/dx(idx);
        starts(1) = start;
    else
        dx(length(dx) + 1) = stop - start;
        slope(length(slope) + 1) = (f(stop) - f(start))/dx(idx);
        starts(length(starts) + 1) = start;
    end
    
%     if length(slope) > 1
%         if slope(length(slope)) < 0 && slope(length(slope)-1) > 0
%             plot(start, f(start), 'marker', 'o')
%             peak(peakIndex) = start;
%             peakIndex = peakIndex + 1;
%         end
%     end
%     
%     line([start, stop], [f(start), f(stop)], 'Color', 'k');
%     plot(start, f(start), 'marker', 'x', 'Color', 'k')
%     hold on;
    idx = idx + 1;
    start = stop;
    
end

end
