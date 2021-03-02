%Intent: To generate a gausian (normal) distribution
%Precond: integer values for mean and standar deviation (stdDev)
%         for the gaussian
%Postcond: The generation of a gaussian centered around the mean
%          With a spread of stdDev

function randomGauss = customGausianDist(mean,stdDev)


randomGauss = stdDev*randn() + mean;