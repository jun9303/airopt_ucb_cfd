n_processors=124;

lb=-1*ones(1,25);
ub=ones(1,25);

gen_intial=readmatrix('InitialGen.txt');

myCluster = parcluster('local');
myCluster.NumWorkers = n_processors;
saveProfile(myCluster);
parpool(n_processors,'IdleTimeout', Inf)
options = optimoptions('gamultiobj','DistanceMeasureFcn',{@distancecrowding,'phenotype'},'ConstraintTolerance',1e-4,'MaxGenerations',1,'PopulationSize',372,'UseParallel',true, 'UseVectorized', false, 'InitialPopulationMatrix', gen_intial,'Display','iter','OutputFcn',@gaoutfun, 'FunctionTolerance',10^-8);
[x,fval,exitflag,output,population,scores] = gamultiobj(@(x) airfoil_wrapper(x),25,[],[],[],[],lb,ub,[],options);
poolobj = gcp('nocreate');
delete(poolobj);

save('GAOutput')
