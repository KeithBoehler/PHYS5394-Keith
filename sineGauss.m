%Intent: Function to generate sine gaussian waves
%Precond: Have a predeterminded data vector dataX, Signal to noise ratio,
%and Param Struct, params
%Postcond: A sinegausian wave will be returned to main program

function sigVec = sineGauss(dataX,snr,params)
phaseVec = 2*pi*params.freq0*dataX+params.phi0;
gausSig = exp(-(dataX-params.mean).^2/(2*params.stdev^2));
sinSig = sin(phaseVec);
sigVec = gausSig.*sinSig;
sigVec = snr*sigVec/norm(sigVec);