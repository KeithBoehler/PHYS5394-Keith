% Final Lab 1

params = struct('mean', 0.5,...
           'stdev', 0.13,...
           'freq0', 22,...
           'phi0', pi/2.0);
snr = 9; % amplitude

% Generate time vector of 1s
samplFreq = 1024; %hz
samplInterval = 1/samplFreq;
timeVec = 0:samplInterval:1.0; % 1s in 1024 res

% Generate the sine-gaussian signal
sigVec = sineGauss(timeVec,snr,params);

% Plot the signal
figure;
plot(timeVec, sigVec, 'Marker', '.', 'MarkerSize', 6);
title('Sine-Gaussian Signal Using Struct');
xlabel('Seconds (s)');
ylabel('Amplitude');

% generate periodogram
nSampl  = length(timeVec);
dataLen = timeVec(end)-timeVec(1);
kNyq = floor(nSampl/2)+1; % Nyquist freq
posFreq = (0:(kNyq-1))*(1/dataLen); % vector of positive Fourier frequencies
% FFT of the signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

% Plot periodogram
figure;
plot(posFreq, abs(fftSig));
title('Periodogram of Sine-Gaussian');
xlabel('Frequency (Hz)');
ylabel('Magnitude');