%%
%% plotting IV results - both:
%% One sample: two-stage IV probit
%% Two sample: MR Egger, weighted median, MBE
%%

%sens='-sensitivity';
sens='';

resDir=getenv('RES_DIR');

xonesample = dataset('file', strcat(resDir,'/results-21753/nervous-followup/nervous-results.csv'));
x = dataset('file', strcat(resDir,'/results-21753/nervous-followup/estimates',sens,'.txt'), 'delimiter', ',');
discovery = dataset('file', strcat(resDir,'/results-21753/nervous-followup/nervous-results-replication-sample1.csv'));
discovery.test = strcat(discovery.test, '_disc');
replication = dataset('file', strcat(resDir,'/results-21753/nervous-followup/nervous-results-replication-sample2.csv'));
replication.test = strcat(replication.test, '_rep');


% combine one and two sample results
x = [x; xonesample;discovery;replication];

%ps={'o'; '*'; '+'; '^'; 's'; 'd'; '<'; '>'; '.'; '*'};
%cs={'r'; 'g'; 'b'; [0.6 0.6 0.3]; 'm'; 'c'; 'b'; [0.5 0.5 0.5]; [0.1 0.1 0.1]; [0.6 0.3 0.6] };

fcs={'r';'w';[0.7 0 0];'b';'b';'g';'w';'m';[0.6 0.3 0.6];'w'};
cs={'r';'r';'r';'b';'b';'g';'g';'m';[0.6 0.3 0.6];[0.6 0.3 0.6]};
ps={'o'; 'o'; 'o'; '<'; '>'; 's'; 's'; '*'; 'd'; 'd'};


h=[];
hx=figure;
plot([0 40], [0 0], '--', 'color', [0.2 0.2 0.2]);


offset=0
for fid=[1970, 1980, 1990, 2010]

% field 1970
ix = find(strcmp(x.field, strcat('x',num2str(fid),'_0_0', sens))==1);
resx = x(ix,:);

ix0 = find(strcmp(resx.test, '97_stdbmi_logodds')==1);
ix01 = find(strcmp(resx.test, '96_stdbmi_logodds')==1);
ix02 = find(strcmp(resx.test, 'fto_stdbmi_logodds')==1);

ix0d = find(strcmp(resx.test, '97_stdbmi_logodds_disc')==1);
ix0r = find(strcmp(resx.test, '97_stdbmi_logodds_rep')==1);

ix00 = find(strcmp(x.test, 'ivwest')==1);
ix1 = find(strcmp(resx.test, 'mreggerest')==1);
ix2 = find(strcmp(resx.test, 'mreggerestSIMEX')==1);
ix3 = find(strcmp(resx.test, 'weightmedest')==1);
ix4 = find(strcmp(resx.test, 'MBE_Simple_0.75')==1);
ix5 = find(strcmp(resx.test, 'MBE_Weighted_0.75')==1);

ixs = [ix0 ix01 ix02 ix0d ix0r ix1 ix2 ix3 ix4 ix5];
for i=1:length(ixs)
	ixx = ixs(i);

	% ci
	hold on;plot([offset+i*0.7 offset+i*0.7], [resx.lower(ixx) resx.upper(ixx)], '-', 'color', cs{i}); 
	
	% estimate point
	hold on;h(i)=plot(offset+i*0.7, resx.estimate(ixx), ps{i}, 'color', cs{i}, 'MarkerFaceColor', fcs{i});
end

offset = offset+10

end


lgd=legend(h, {'TS probit, full sample, 97 SNPs';'TS probit, full sample, 96 SNPs';'TS probit, full sample FTO'; 'TS probit, discovery sample'; 'TS probit, replication sample'; 'Egger'; 'Egger (SIMEX)'; 'Weighted median'; 'MBE(simple) \phi=0.75'; 'MBE(weighted) \phi=0.75'});
lgd.Position = [0.48 0.625 0.3161 0.2821];
%legend('boxoff')


set(gca, 'XTick', [3:10:33]);
set(gca,'XTickLabel', {'Nervous (FID=1970)';'Worrier (FID=1980)';'Tense (FID=1990)';'Nerves (FID=2010)'});

set(gca, 'YTick', [-0.6:0.2:0.6]);

xlabel('Outcome variable');
ylabel('Log odds');

ylim([-0.6 0.6]);
xlim([0 40]);

saveas(hx, strcat(resDir, '/results-21753/nervous-followup/iv-results',sens,'.pdf'));



