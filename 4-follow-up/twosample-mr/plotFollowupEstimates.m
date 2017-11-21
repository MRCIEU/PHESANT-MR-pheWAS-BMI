
resDir=getenv('RES_DIR');

xonesample = dataset('file', strcat(resDir,'/nervous-followup/nervous-results.csv'));
x = dataset('file', strcat(resDir,'/nervous-followup/estimates.txt'), 'delimiter', ',');

% combine one and two sample results
x = [x; xonesample];

ps={'o'; '*'; '+'; '^'; 's'; 'd'; '<'; '>'};cs={'r'; 'g'; 'b'; [0.6 0.6 0.3]; 'm'; 'c'; 'b'; [0.5 0.5 0.5]};

h=[];
hx=figure;
plot([0 40], [0 0], '--', 'color', [0.2 0.2 0.2]);


% 1970
ix = find(strcmp(x.field, 'x1970_0_0')==1);
ix0 = find(strcmp(x.test(ix), '96_stdbmi_logodds')==1);
ix1 = find(strcmp(x.test(ix), 'mreggerest')==1);
ix2 = find(strcmp(x.test(ix), 'mreggerestSIMEX')==1);
ix3 = find(strcmp(x.test(ix), 'weightmedest')==1);
ix4 = find(strcmp(x.test(ix), 'MBE_Simple_0.75')==1);
ix5 = find(strcmp(x.test(ix), 'MBE_Weighted_0.75')==1);

xix = x(ix,:);

ixs = [ix0 ix1 ix2 ix3 ix4 ix5];
for i=1:6
	ixx = ixs(i);
	hold on;plot([i i], [xix.lower(ixx) xix.upper(ixx)], '-', 'color', cs{i}); 
	hold on;h(i)=plot(i, xix.estimate(ixx), ps{i}, 'color', cs{i});
end



% 1980
ix = find(strcmp(x.field, 'x1980_0_0')==1);
ix0 = find(strcmp(x.test(ix), '96_stdbmi_logodds')==1);
ix1 = find(strcmp(x.test(ix), 'mreggerest')==1);
ix2 = find(strcmp(x.test(ix), 'mreggerestSIMEX')==1);
ix3 = find(strcmp(x.test(ix), 'weightmedest')==1);
ix4 = find(strcmp(x.test(ix), 'MBE_Simple_0.75')==1);
ix5 = find(strcmp(x.test(ix), 'MBE_Weighted_0.75')==1);

xix = x(ix,:);

ixs = [ix0 ix1 ix2 ix3 ix4 ix5];
for i=1:6
        ixx = ixs(i);
        hold on;plot([10+i 10+i], [xix.lower(ixx) xix.upper(ixx)], '-', 'color', cs{i});
        hold on;h(i)=plot(10+i, xix.estimate(ixx), ps{i}, 'color', cs{i});
end

% 1990
ix = find(strcmp(x.field, 'x1990_0_0')==1);
ix0 = find(strcmp(x.test(ix), '96_stdbmi_logodds')==1);
ix1 = find(strcmp(x.test(ix), 'mreggerest')==1);
ix2 = find(strcmp(x.test(ix), 'mreggerestSIMEX')==1);
ix3 = find(strcmp(x.test(ix), 'weightmedest')==1);
ix4 = find(strcmp(x.test(ix), 'MBE_Simple_0.75')==1);
ix5 = find(strcmp(x.test(ix), 'MBE_Weighted_0.75')==1);

xix = x(ix,:);

ixs = [ix0 ix1 ix2 ix3 ix4 ix5];
for i=1:6
	ixx = ixs(i);
        hold on;plot([20+i 20+i], [xix.lower(ixx) xix.upper(ixx)], '-', 'color', cs{i});
        hold on;h(i)=plot(20+i, xix.estimate(ixx), ps{i}, 'color', cs{i});
end


% 2010
ix = find(strcmp(x.field, 'x2010_0_0')==1);
ix0 = find(strcmp(x.test(ix), '96_stdbmi_logodds')==1);
ix1 = find(strcmp(x.test(ix), 'mreggerest')==1);
ix2 = find(strcmp(x.test(ix), 'mreggerestSIMEX')==1);
ix3 = find(strcmp(x.test(ix), 'weightmedest')==1);
ix4 = find(strcmp(x.test(ix), 'MBE_Simple_0.75')==1);
ix5 = find(strcmp(x.test(ix), 'MBE_Weighted_0.75')==1);

xix = x(ix,:);

ixs = [ix0 ix1 ix2 ix3 ix4 ix5];
for i=1:6
	ixx = ixs(i);
        hold on;plot([30+i 30+i], [xix.lower(ixx) xix.upper(ixx)], '-', 'color', cs{i});
        hold on;h(i)=plot(30+i, xix.estimate(ixx), ps{i}, 'color', cs{i});
end





legend(h, {'tsls'; 'Egger'; 'Egger (SIMEX)'; 'Weighted median'; 'MBE(simple) \phi=0.75'; 'MBE(weighted) \phi=0.75'}, 'location', 'best');
set(gca, 'XTick', [3:10:33]);
set(gca,'XTickLabel', {'Nervous (1970)';'Worrier (1980)';'Tense (1990)';'Nerves (2010)'});

xlabel('Outcome variable');
ylabel('Log odds');

saveas(hx, strcat(resDir, '/nervous-followup/iv-results.pdf'));

