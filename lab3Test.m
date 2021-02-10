% Test Script for lab 3

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

% Plot the data
figure;
plot(timeVec, sigVec)


