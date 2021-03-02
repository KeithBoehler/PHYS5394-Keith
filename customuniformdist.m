%Intent: Create a uniform puesdo random distribution
%Precond: Have integers to establish endpoints start and end
%Postcon: Uniform distribution spaning start and end


function randValueL7U = customuniformdist(startp,endp)


randValueL7U = (endp -startp)*rand() + startp;