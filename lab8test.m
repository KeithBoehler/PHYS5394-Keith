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