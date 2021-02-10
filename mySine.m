% Generic Sin, Keith Boehler
% Intent: A function to call and generate sine funcs
% Precond: Amplidue, phase (between 0-2pi), sampleing freq to 
%          generate sample vector, f0 for the ordinary freq (Hz)
%          Duration in seconds. 
% Post Condition: Sine func generated 


function mySineW = mySine(sampleFreq, f0, Amp, phase, T)
    % Generate sample vect. Starts 0 and ends at T
    t = 0 : 1 / sampleFreq : T; 
    angularFreq = 2 * pi * f0; % aka omega
    y = Amp * sin(angularFreq * t + phase);
    mySineW = y;
end