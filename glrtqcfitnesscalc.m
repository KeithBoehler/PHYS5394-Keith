%Pourpose: to calculate the pso for glrts
%Precond: Give parameters suck as min, max, snr, etc
%          and vector with data tk calc pso on
%PostCond:return a vector with fitness function having being calculated 
%Bugs: 

function [fitness_values,varargout] = glrtqcfitnesscalc(xVec,params)
[nVecs,~]=size(xVec);

fitness_values = zeros(nVecs,1);

boundary_chk = crcbchkstdsrchrng(xVec);
%Set fitness for invalid points to infty
fitness_values(~boundary_chk)=inf;
xVec(boundary_chk,:) = s2rv(xVec(boundary_chk,:),params);

for lpc = 1:nVecs
    if boundary_chk(lpc)
        x = xVec(lpc,:);
        phaseVec = x(1)*params.dataX + x(2)*params.dataXSq + x(3)*params.dataXCb;
        qc = sin(2*pi*phaseVec);
        normSigSqrd = innerprodpsd(qc,qc,params.samplFreq,params.psdVec);
        normFac = params.snr/sqrt(normSigSqrd); % Factor to normalize qc
        qc = normFac*qc; % Normalize qc

        % fitness calc
        fitness_values = -innerprodpsd(params.dataY,qc,params.samplFreq,params.psdVec)^2;
    end
end
