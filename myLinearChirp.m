% Lab 3, Keith Boehler
% Linear Chirp

% Variable place holders

function linCh = myLinearChirp(dataX, snr, coef)
    % TO DO
    phaseVec = coef * dataX; % Calculation of the phase vect
    t = 0:1/10000:2;
    sigVec = sin(2*pi*phaseVec.*dataX); % Calc of sig vector
    sigVec = snr * (sigVec / norm(sigVec)); % Normalize
    linCh = sigVec; % set to return
end
