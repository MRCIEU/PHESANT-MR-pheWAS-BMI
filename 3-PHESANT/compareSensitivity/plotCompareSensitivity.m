
resDir=getenv('RES_DIR');
file=strcat(resDir,'/results-compare-main-sensitivity.txt');

mydata = dataset('file', file, 'delimiter', ',');
datax = mydata.pvalueMain;
datay = mydata.pvalueSens;

ix = find(datax == 0);
datax(ix) = 10^-320;
iy = find(datay == 0);
datay(iy) = 10^-320;


ax=0;

% plot main analysis P values against the sensitivity analysis
h=figure; 

plot([10^-320 1], [10^-320 1], '--', 'color', [0.8 0.4 0.6]);

hold on;
plot(double(datax), double(datay), 'o','MarkerSize',10, 'MarkerEdgeColor', [0 0.0 0.8], 'MarkerFaceColor',[0.1 0.5 0.4] );

% log scale
set(gca, 'XScale', 'log'); set(gca, 'YScale', 'log');

% plot bonferroni threshold
hold on; plot([ax+0.05/15416, ax+0.05/20461], [10^-300, 1], '--', 'color', [0 0.6 0.0]);
hold on; plot([10^-300, 1], [ax+0.05/20461, ax+0.05/20461], '--', 'color', [0 0.6 0.0]);

% plot FDR=5% threshold
hold on; plot([ax+1.27e-3 ax+1.27e-3], [10^-300, 1], ':', 'color', [0.0 0.0 0.6]);
hold on; plot([10^-300, 1], [ax+1.27e-3, ax+1.27e-3], ':', 'color', [0.0 0.0 0.6]);

% set plot limits
xlim([0+ax 1+ax]);ylim([0+ax 1+ax]);

% axis labels
xlabel('Main MR-pheWAS'); ylabel('Sensitivity analysis');

% set values to display axis values for
set(gca, 'XTick', [10^-300 10^-250 10^-200 10^-150 10^-100 10^-50 1]);
set(gca, 'YTick', [10^-300 10^-250 10^-200 10^-150 10^-100 10^-50 1]);

% save to file

saveas(h, strcat(resDir, '/main-sensitivity-compare.pdf'));

xlim([10^-100 1]);

