
% first direct search
% generate some random points
cn = 48;

max_runs = 10;

globalResults = zeros(3,max_runs);


tic;
for run=1:max_runs

    n = 20;
    points = (rand(cn,n) - 0.5) * 2 * 10;
    evals = zeros(1,n);
    results = zeros(cn+1,n);

    options = psoptimset ( 'CompletePoll', 'off', 'Display', 'off' );

    for i=1:n
        [x, fval, exitflag, options] = patternsearch ( @tsp, points(:,i), [], [],[],[], -1e5, 1e5, options  );
        results(1:cn,i) = x;
        results(cn+1,i) = fval-optTour();
        evals(1,i) = options.iterations;
    end


    globalResults (1,run) = sum(evals);
    globalResults (2,run) = mean(results(cn+1,:));

    if run == 1
        figure;
        [k,l] = min ( results(cn+1,:) );
        plotcities ( results(1:cn,l) );
        title ('Results for TSP-fun -  first sucessfull poll');
    end

end

display ( ['elapsed time: ' num2str(toc) ]);
display ( ['mean f-evals: ' num2str(mean(globalResults(1,:))) ]  );
display ( ['average f-val: ' num2str(mean(globalResults(2,:))) ]  );

% plot best points
figure;
hist ( globalResults(1,:) );
title ('Function evaluations for Ras-fun - first sucessfull poll');
pause;

options = psoptimset ( 'CompletePoll', 'on', 'Display', 'off' );

tic;
for run=1:max_runs
    for i=1:n
        [x, fval, exitflag, options] = patternsearch ( @tsp, points(:,i), [], [],[],[], -1e5, 1e5, options  );
        results(1:cn,i) = x;
        results(cn+1,i) = fval-optTour();
        evals(1,i) = options.iterations;
    end


    globalResults (1,run) = mean(evals);
    globalResults (2,run) = mean(results(cn+1,:));

    if run == 1
        figure;
        [k,l] = min ( results(cn+1,:) );
        plotcities ( results(1:cn,l) );
        title ('Results for TSP-fun -  complete poll');
    end

end

display ( ['elapsed time: ' num2str(toc) ]);
display ( ['mean f-evals: ' num2str(mean(globalResults(1,:))) ]  );
display ( ['average f-val: ' num2str(mean(globalResults(2,:))) ]  );

% plot best points
figure;
hist ( globalResults(1,:) );
title ('Function evaluations for TSP-fun - complete poll');
pause;

pops = 5:5:100;
j =1;
results = zeros(2,length(pops));
evals = zeros(1,length(pops));
xs = [];
bestval =Inf;
bestindex =0;
tic;
for i = pops
    for runs=1:max_runs
        options = gaoptimset ( 'PopInitRange', [-20;20], 'PopulationSize', i );
        [x, fval, reason, output, pop, score] = ga(@tsp, cn, options);
        results(:, j) = results(:, j) + [ i; fval-optTour() ];
        evals(j) = evals(j) + output.funccount;
        
        if ( (fval-optTour) < bestval) 
            bestval = fval-optTour;
            bestindex = size(xs,2)+1;
        end
        
        xs = [ xs x' ];
    end
    j = j+1;
end

results = results / max_runs;
evals = evals / max_runs;

display ( ['elapsed time: ' num2str(toc) ]);
display ( ['mean f-evals: ' num2str( mean(evals)) ]  );
display ( ['average f-val: ' num2str( mean(results(2,:))) ]  );

figure
plot ( results(1,:), results(2,:) );
title ('Function values for TSP');
figure
plot ( results(1,:), evals );
xlabel ('population size');
title ('Function evaluations for TSP');
ylim ([0 max(evals)*1.2]);
xlabel ('population size');
figure
plotcities ( xs(:,bestindex));
title (['Best tour for TSP with GA - error: ' num2str(bestval) ' mi.' ]);
hold off;

pause;

max_runs = 20;
results = zeros(cn+2,max_runs);
tic;
for runs = 1:max_runs

    options = anneal();
    options.InitTemp = 5000;
    options.Verbosity =0;
    options.Generator =  @(x) (x+(randperm(length(x))==length(x))*randn*500);
    [x f evals] = anneal (@tsp, (rand(1,cn)-0.5)*40, options);
    results(:, runs) = [ x'; f-optTour; evals];
end

display ( ['elapsed time: ' num2str(toc) ]);
display ( ['mean f-evals: ' num2str( mean(results(cn+2,:))) ]  );
display ( ['average f-val: ' num2str( mean(results(cn+1,:))) ]  );

figure
[k l] = min (results(cn+1));
plotcities ( results(1:cn, l));
title (['Best tour for TSP with SA - error: ' num2str(k) ' mi.' ] );



