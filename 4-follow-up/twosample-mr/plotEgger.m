
%%%%%%
%%%%%% get the data

function plotEgger(v)

resDir=getenv('RES_DIR');
dataDir=getenv('PROJECT_DATA');

varName = strcat('x', v, '_0_0');

% mr egger, weighted median and mbe estimates
myEstimates = dataset('file', strcat(resDir,'/nervous-followup/estimates.txt'), 'delimiter',',');

% snp exposure associations
x = dataset('file', 'locke-data.txt', 'delimiter', '\t');

% snp outcome associations
data = dataset('file', strcat(dataDir,'/phenotypes/derived/followup-assoc-for-egger',varName,'.csv'), 'delimiter', ',');


%%%%%%
%%%%%% prepare the data

xx = join(x, data, 'Keys', 'snp', 'mergekeys', true);


results = myEstimates(find(strcmp(myEstimates.field,varName)==1), :);
weightmedest = results(find(strcmp(results.test,'weightmedest')==1),:);
mreggerest = results(find(strcmp(results.test, 'mreggerest')==1),:);
mreggerint = results(find(strcmp(results.test, 'mreggerint')==1),:);

weightmedest = weightmedest.estimate;
mreggerest = mreggerest.estimate;
mreggerint = mreggerint.estimate;


%% axis limits
xmin=0;
xmax=max(xx.beta)+0.01;
ymin=min(xx.outcomebeta)-0.03;
ymax=max(xx.outcomebeta)+0.03;


xx.lowerCI = xx.beta - 1.96*xx.se;
xx.upperCI = xx.beta + 1.96*xx.se;
xx.outcomelowerCI = xx.outcomebeta - 1.96*xx.outcomese;
xx.outcomeupperCI = xx.outcomebeta + 1.96*xx.outcomese;


%%%%%%
%%%%%% make the plot

h=figure;

% plot zero lines

plot([xmin xmax], [0 0], '--', 'color', [0.5 0.5 0.5]);
hold on;
plot([0 0], [ymin ymax], '--', 'color',	[0.5 0.5 0.5]);


% plot snp confidence intervals

colx = [0.7 0 0.9];
for i=1:size(xx,1)
	hold on;
	plot([xx.lowerCI(i) xx.upperCI(i)], [xx.outcomebeta(i) xx.outcomebeta(i)], '-', 'color', colx);
	hold on;
	plot([xx.beta(i) xx.beta(i)], [xx.outcomelowerCI(i), xx.outcomeupperCI(i)], '-', 'color', colx);
end


% plot snp association estimates

plot(xx.beta, xx.outcomebeta, 'o', 'color', colx);
xlabel('Genetic association with BMI');

ylabel(strcat('Genetic association with ', v));

% plot association estimates

%% MR Egger
hold on;
plot([xmin xmax], [mreggerest*xmin+mreggerint mreggerest*xmax+mreggerint], '-', 'color', [0 0 0.8]);

%% weighted median
hold on;
plot([xmin xmax], [weightmedest*xmin weightmedest*xmax], '--',	'color', [0.1 0.8 0.1]);

%% MBE
%hold on;
%plot([xmin xmax], [mbeEst*xmin mbeEst*xmax], '-',     'color', [0 0.8 0]);


xlim([xmin xmax]);
ylim([-0.1 0.06]);

grid on
daspect([1 1 1])

saveas(h, strcat(resDir, '/nervous-followup/sensitivityplot-',varName,'.pdf'));




