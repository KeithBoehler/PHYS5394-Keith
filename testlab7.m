% Test script for uniform and Gausian Dists

trials = 10000;

% Stats for Gauss dist
mean = 5;
standardDev = 5;

% Stats for uniform dist
start = 1;
end1 = 8;

for i = 1:trials;
   % populate vectors with probability 
   % distribution fucntions (PDF)
   
   uniformPDF(i) = customuniformdist(start, end1);
   gaussPDF(i) = customGausianDist(mean, standardDev);
   
end

