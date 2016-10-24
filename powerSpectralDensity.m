% powerSpectralDensity

function spectra = powerSpectralDensity(dataSegment, Fs)

    N = length(dataSegment);
    xdft = fft(dataSegment);
    xdft = xdft(1:N/2+1);
    psdx = (1/(Fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    % Frequency bins
    freq = 0:Fs/length(dataSegment):Fs/2;
    spectra = 10*log10(psdx);
    plot(freq, spectra)
end