% Generic Sin, Keith Boehler
% Intent: A function to call and generate sine funcs
% Precond: Amplidue, phase (between 0-2pi), sampleing freq to generate sample vector,
%         f0 for the ordinary freq (Hz)
% Post Condition: Sine func generated 


function mySineW = mySine(sampleFreq, f0, Amp, phase)
    % Generate sample vect. Starts 0 and ends at 1
    t = 0 : 1 / sampleFreq : 1; 
    angularFreq = 2 * pi * f0; % aka omega
    y = Amp * sin(angularFreq * t + phase);
    mySineW = y;
end