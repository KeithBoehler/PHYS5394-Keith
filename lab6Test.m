% Test Script for lab 5
% Setting up a wave to fft on
% Signal Params
a1 = 10;
a2 = 3;
a3 = 3;
A = 10;

% Instantaneous Freq after 1s
maxFreq = a1 + 2*a2 + 3*a3;
sampleFreq = 5 * maxFreq;
sampleIntervel = 1 / sampleFreq;

% Time Samples
timeVec = 0:sampleIntervel:1.0;

% Number of samples
nSamples = length(timeVec);
sigVec = myLinearChirp(timeVec, A, a1);

% Lab 6 Part
% Seperate the values from specogram
% S => Intensity 
% F => Frequency 
% T => Time

[S, F, T] = spectrogram(sigVec, 125, 124, [], sampFreq);
figure;
imagesc(T, F, abs(S)); axis xy;
xlabel("Time (s)");
ylabel("Frequency (Hz)");


