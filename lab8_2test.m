%% Simulate LIGO Noise
% Read the initial LIGO sensitivity PSD
dataLIGO = load('iLIGOSensitivity.txt', '-ascii');


lowCutoff  = 50; %Hz
highCutoff = 700; %Hz

a = 40;
lowSen = dataLIGO(a,2); %low frequency cut off (sensitivity)(bins)

for i = 1:a
    dataLIGO(i,2) = lowSen;
end

b = 50;
highSen = dataLIGO(b,2);

for i = b:length(dataLIGO(:,1))
    dataLIGO(i,2) = highSen;
end

dataLIGO(2:end+1,:) = dataLIGO;
dataLIGO(1,1) = 0; %Hz
dataLIGO(1,2) = lowSen;

sampFreq = 6000; %Hz

upper = 85; % Bin 
dataLIGO = dataLIGO(1:upper,:); % Cut the window down to upper
dataLIGO(upper,1) = 3000; %Hz

% loglog(LIGOSen(:,1),LIGOSen(:,2))

% Generate White Gaussian Noise realization and pass through LIGO PSD filter
nSamples = 2*sampFreq; % 2 (s) * sampFreq

noise = randn(1,nSamples); % A vect for data

% FIR Filt
freqVals  = dataLIGO(:,1);
psdVals   = dataLIGO(:,2);
filtrOrdr = 600; 

b = fir2(filtrOrdr,freqVals/(sampFreq/2),sqrt(psdVals));

noiseLIGOReal = sqrt(sampFreq)*fftfilt(b,noise);

% Estimate PSD w/ pwelch and plot

[pxx, f] = pwelch(noiseLIGOReal, 600, [], [], sampFreq);

figure;
plot(f/1000,pxx);
title('Estimated PSD LIGO');
xlabel('Frequency (kHz)');
ylabel('PSD');