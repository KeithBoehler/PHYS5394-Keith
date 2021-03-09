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
[pxx, f] = pwelch(col2, 256, [], [],sampFreq);
figure;
plot(f, pxx);
xlabel('Freq (Hz)');
ylabel('Power Specral Density');
