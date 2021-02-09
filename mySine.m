% Generic Sin, Keith Boehler
% Intent: A function to call and generate sine funcs
% Precond: Amplidue, phase, and other info will be in mem
% Post Condition: Sine func generated 


function mySineW = mySine(dataX, snr, coef)
    phaseVec = coef * dataX; % Calculation of the phase vect
    sigVec = sin(2*pi*phaseVec); % Calc of sig vector
    sigVec = snr * (sigVec / norm(sigVec)); % Normalize
    mySineW = sigVec; % set to return
end