samplFreq = 1024; % Hz
% dataLen = 4.0; % seconds
samplInterval = 1/samplFreq;
dataX = 0:samplInterval:1.0; % time series vector

% Generate puesdo obj of sine-gaussian signal parameters
params = struct('mean', 0.5,...
           'stdev', 0.13,...
           'freq0', 22,...
           'phi0', pi/2.0);

% Function handle for sinegauss 
H = @(snr) sineGauss(dataX, snr, params);
S = [10 12 15];% Plot sine-gaussian signal at 10, 12, and 15 SNR

% Generate legend cell array and new figure
legVec = [];
figure;
% Loop through snrs, generate signal and add to plot
for snr = S
    % Append snr to legend cell array
    legVec{end+1} = ['snr=',num2str(snr)];
    sigVec = H(snr);
    % Plot the signal
    plot(dataX, sigVec);
    hold on;
end
% Plots
title('Sine-Gaussian Signal (variable SNR)');
xlabel('Time (s)');
ylabel('Amplitude');
legend(legVec);