% Lab 8.1 Test script 

% Load data into memory
path = "/home/keith/Documents/Masters/Classes/Stat Methods/DATASCIENCE_COURSE/NOISE/testData.txt";
data1 = load(path);
% Seperate the data into columns 
col1 = data1(:,1);
col2 = data1(:,2);

% Spread data into pre and post injection of signal

for i=1:length(col1)
   if col1(i) <= 5.0000
       cleanDat1(i) = col1(i);
       cleanDat2(i) = col2(i);
   else
       mystDat1(i) = col1(i);
       mystDat2(i) = col2(i);
   end
end
% Puting them back together 
data = [col1 col2];
cleanDat = [cleanDat1 cleanDat2];
mystDat = [mystDat1 mystDat2];

% Estimating the power specral density using the clean data
sampFreq = 1024; %Hz
[pxx, f] = pwelch(cleanDat2, 256, [], [],sampFreq);
figure;
plot(f, pxx);
xlabel('Freq (Hz)');
ylabel('Power Specral Density');

% Whittening filter
b = fir2(500, f / (1024 / 2), sqrt(pxx));
outNoise = fftfilt(b,col2) % Data has been whitten


figure;
subplot(2,1,1), plot(col1, outNoise);
title('proccessed data');
xlabel('time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(col1, col2);
title('raw data');
xlabel('time (s)');
ylabel('Amplitude');

%% Waterfall plots (spectrogram )
% Norm for two sides
wData = sqrt(sampFreq) * fftfilt(b, col2);
window = floor(1.1 * sampFreq); % Legnth times sampFreq
overlap = floor(1.0 * sampFreq); % Legnth times sampFreq

%[SR, FR, TR] = spectrogram(wData, window, overlap, [], sampFreq); % Raw data
[SW, FW, TW] = spectrogram(wData, window, overlap, [], sampFreq); % Whitten data


% Specto Plots
% figure;
% imagesc(TR, FR, abs(TR));
% title('Raw Spectogram');
% xlabel('time (s)');
% ylabel('Freq (Hz)');

figure;
imagesc(TW, FW, abs(SW));
title('Whitten Spectrogram');
xlabel('time (s)');
ylabel('Freq (Hz)');















