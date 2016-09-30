% Gets abdominal, thorax and obstruction data from the given index.

function [abdo, thorax, obstr] = getFilteredSignals(sigNum)
    % Assign variables to data in base workspace
    abdominalSignals = evalin('base','abdominalSignals');
    thoraxSignals = evalin('base','thoraxSignals');
    obstrSignals = evalin('base','obstrSignals');
    vectorLengths = evalin('base','vectorLengths');
    
    % Get corrresponding signals from data
    abdo = abdominalSignals(:, sigNum);
    thorax = thoraxSignals(:, sigNum);
    obstr = obstrSignals(:, sigNum);
    
    % reduce to true size
    abdo = abdo(1:vectorLengths(sigNum));
    thorax = thorax(1:vectorLengths(sigNum));
    obstr = obstr(1:vectorLengths(sigNum));
    
    % Filter abdo and thorax signals and downsample obstruction signal
    abdo = downsampleFilter(abdo);
    thorax = downsampleFilter(thorax);
    obstr = downsample(obstr, 25);
end

    
    