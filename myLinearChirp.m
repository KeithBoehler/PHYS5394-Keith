% Lab 3, Keith Boehler
% Linear Chirp

% Variable place holders

function linCh = myLinearChirp(dataX, snr, coef)
    % TO DO
    phaseVec = coef * dataX; % Calculation of the phase vect
    sigVec = sin(2*pi*phaseVec); % Calc of sig vector
    sigVec = snr * (sigVec / norm(sigVec)); % Normalize
    linCh = sigVec; % set to return
end
