% Lab 4 

% Brining in prev work for data generation
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

% Generate the sig
sigVec = myLinearChirp(timeVec, A, a1);


% Nyquist Calcs 
nyFreq = floor(sampleFreq / 2) + 1;
nyFreqHalf = floor(nyFreq / 2);
nyFreq5 = floor(5 * nyFreq); 

% Positive FFT Freq
% Half Sample 
posFreqHalf = (0:(nyFreqHalf-1))*(1/dataLen);
fftSigHalf = fft(sigVec);
fftSigHalf = fftSigHalf(1:nyFreq); % Letting go of neg Freq
% Over sample x5
posFreq5 = (0:(nyFreq5-1))*(1/dataLen);
fftSig5 = fft(sigVec);
fftSig5 = fftSig5(1:nyFreq); % Letting go of Neg Freq

% Plots



