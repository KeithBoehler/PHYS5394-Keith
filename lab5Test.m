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

% FFT Part
timeVec = 0:sampleIntervel:1.0;
%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
title('periodogram');
xlabel('samples');
ylabel('FFT');
% Part 2 of Lab 5
% Building 3 sine waves from table in slides

s1 = mySine(1024, 100, 10, 0, 1);
s2 = mySine(1024, 200, 5, pi/6, 1);
s3 = mySine(1024, 300, 2.5, pi/4, 1);
S = s1 + s2 + s3;

% Low pass filter
filtOrder = 30;
maxFreq = 300;
sampFreq = 1024;
b = fir1(filtOrder, (100/2) / (sampFreq/2), 'low');
plt1 = fftfilt(b, S);
figure;
hold on;
plot(plt1);
title('Low Pass Filter');
xlabel('samples');
ylabel('FFT');

% High Pass
filtOrder = 30;
maxFreq = 300;
sampFreq = 1024;
b = fir1(filtOrder, (100/2) / (sampFreq/2), 'high');
plt1 = fftfilt(b, S);
figure;
hold on;
plot(plt1);title('High Pass Filter');
xlabel('samples');
ylabel('FFT');

% Band pass

filtOrder = 30;
maxFreq = 300;
sampFreq = 1024;
b = fir1(filtOrder, (100/2) / (sampFreq/2), 'bandpass');
plt1 = fftfilt(b, S);
figure;
hold on;
plot(plt1);
title('Bandpass Filter');
xlabel('samples');
ylabel('FFT');




