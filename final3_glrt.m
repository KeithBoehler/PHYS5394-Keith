% Set up Color Gauss and qc 
samplFreq = 1024; %Hz
nSamples = 2048;
dataLen = nSamples/samplFreq;
dataX = (0:(nSamples-1))/samplFreq;

tpsd = @(f) (f>=0 & f<=200).*(200-f).*((sin(f/6)*0.3+1))/10000 + 1;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdVec = tpsd(posFreq);

% Color Noise 
filtOrdr = 100;
rng('default');
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdVec(:)],filtOrdr,samplFreq);
snr = 10;
params_qc = [2,0.3,10];
sigVec = crcbgenqcsig(dataX,snr,params_qc);
normSigSqrd = innerprodpsd(sigVec,sigVec,samplFreq,psdVec);
sigVec = snr*sigVec/sqrt(normSigSqrd);

dataVec = noiseVec + sigVec;

% Where to put data
% span for parameters. 
param1 = [1,10];
param2 = [-5,0.5];
param3 = [-50,50];
step_size = 0.1;
matrix_vals = param1(1):step_size:param1(2);
row_len = length(matrix_vals);

% declare colums and pop with data
nums1 = (matrix_vals-param1(1))./(param1(2)-param1(1));
col1 = nums1';
nums2 = (params_qc(2)-param2(1))/(param2(2)-param2(1));
col2 = zeros(length(nums1),1) + nums2;
nums3 = (params_qc(3)-param3(1))/(param3(2)-param3(1));
col3 = zeros(length(nums1),1) + nums3;

data_total = [col1,col2,col3];

glrt_params = struct('dataX',dataX,...
                'dataXSq',dataX.^2,...
                'dataXCb',dataX.^3,...
                'dataY',dataVec,...
                'samplFreq',samplFreq,...
                'psdVec',psdVec,...
                'snr',snr,...
                'rmin',[param1(1),param2(1),param3(1)],...
                'rmax',[param1(2),param2(2),param3(2)]);
            
glrt_data = ones(1,row_len); % Populate data matrix

for n = 1:row_len
    glrt_data(n) = glrtqcfitnesscalc(data_total(n,:),glrt_params); % fitness calc
end

idmin = find(glrt_data == min(glrt_data));

figure;
plot(matrix_vals,glrt_data,'-p','MarkerIndices',[idmin],'MarkerFaceColor','blue','MarkerSize',20);
title('Fitness Values vs QC Parameter Range');
xlabel('Values for a1');
ylabel('Fitness Value (-GLRT)');
legend({'Min @ a1 = 2'},'Position','SE');

