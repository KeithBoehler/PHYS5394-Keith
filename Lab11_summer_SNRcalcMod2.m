%% How to normalize a signal for a given SNR
snr = 10;

% Data generation parameters
nSamples = 2048;
samplFreq = 1024;
x = (0:(nSamples-1))/samplFreq;

%%
% Signal Params
a1 = 10;
a2 = 3;
a3 = 3;
A = 10;
%%
% Data generation parameters
nSamples = 2048;
sampFreq = 1024;
x = (0:(nSamples-1))/sampFreq;

sigVec = myLinearChirp(x, A, a1);
%% Use iLIGOSensitivity.m to generate a PSD vector
% Read Ligo Sensitivity PSD
LIGOSen = load('iLIGOSensitivity.txt', '-ascii');

% Pre-filtering
lowCutoff  = 50; %Hz
% Low Frequency Cutoff
lowSn = LIGOSen(42,2); 
LIGOSen(1:42,2) = lowSn;

% High Frequency Cutoff
highCutoff = samplFreq/2; %Hz
LIGOSen(67,1) = highCutoff;
LIGOSen = LIGOSen(1:67,:); 

% Insert f = 0 sampling freq
LIGOSen(2:end+1,:) = LIGOSen;
LIGOSen(1,1) = 0; %Hz
LIGOSen(1,2) = lowSn;

% Interpolate sensitivity values to match length(PSDVals)
dataLen = nSamples/samplFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen); % Positive DFT frequencies

PSDVals = interp1(LIGOSen(:,1),LIGOSen(:,2),posFreq);

PSDVals = PSDVals.^2;
%*******************************

%% Calculation of the norm
normSigSqrd = innerprodpsd(sigVec,sigVec,samplFreq,PSDVals);
% Normalize signal to specified SNR
sigVec = snr*sigVec/sqrt(normSigSqrd);

nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:), PSDVals(:)],100,samplFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,samplFreq,PSDVals);
end
%Obtain LLR for multiple data (=signal+noise) realizations
nH1Data = 1000;
llrH1 = zeros(1,nH1Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:), PSDVals(:)],100,samplFreq);
    dataVec = noiseVec + sigVec;
    llrH1(lp) = innerprodpsd(dataVec,sigVec,samplFreq,PSDVals);
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

figure;
histogram(llrH0);
hold on;
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H_0','H_1');
title(['Estimated SNR = ',num2str(estSNR)]);

%% Plot data and signal realizations
figure;
plot(x,dataVec);
hold on;
plot(x,sigVec);
title('Data and Signal Realizations');
xlabel('Time (sec)');
ylabel('Data');

%% Generate and plot the periodogram of signal and data

% FFT of the data
fftData = fft(dataVec);
% Take positive fourier frequencies
fftData = fftData(1:kNyq);
% FFT of signal (positive frequencies)
fftSig = fft(sigVec);
fftSig = fftSig(1:kNyq);

% Plot periodogram of signal
figure;
plot(posFreq, abs(fftData));
hold on;
plot(posFreq, abs(fftSig));
title('Periodogram of Exponentially Damped Sinosoidal Wave:')
xlabel('Frequency (Hz)');
ylabel('Periodogram');

%% Plot the spectrogram
winLen = 0.05;
ovrlp  = 0.04;

% Convert to integer number of samples
winLenSampl = floor(winLen*samplFreq);
ovrlpSampl  = floor(ovrlp*samplFreq);
[S,F,T]     = spectrogram(sigVec, winLenSampl, ovrlpSampl,[],samplFreq);

% Plot the spectrogram
figure;
imagesc(T,F,abs(S)); axis xy;
title('Spectrograph of Exponentially Damped Sinusoid:')
xlabel('Time (s)');
ylabel('Frequency (Hz)');