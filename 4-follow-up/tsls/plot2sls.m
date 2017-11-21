
resDir=getenv('RES_DIR');

resx = dataset('file', strcat(resDir,'/nervous-followup/nervous-results.csv'));

i1 = find(strcmp(resx.field,'x1970_0_0')==1 & strcmp(resx.test,'96_main')==1);
i2 = find(strcmp(resx.field,'x1970_0_0')==1 & strcmp(resx.test,'95_main')==1);
i3 = find(strcmp(resx.field,'x1970_0_0')==1 & strcmp(resx.test,'fto_main')==1);
i4 = find(strcmp(resx.field,'x1980_0_0')==1 & strcmp(resx.test,'96_main')==1);
i5 = find(strcmp(resx.field,'x1980_0_0')==1 & strcmp(resx.test,'95_main')==1);
i6 = find(strcmp(resx.field,'x1980_0_0')==1 & strcmp(resx.test,'fto_main')==1);
i7 = find(strcmp(resx.field,'x1990_0_0')==1 & strcmp(resx.test,'96_main')==1);
i8 = find(strcmp(resx.field,'x1990_0_0')==1 & strcmp(resx.test,'95_main')==1);
i9 = find(strcmp(resx.field,'x1990_0_0')==1 & strcmp(resx.test,'fto_main')==1);
i10 = find(strcmp(resx.field,'x2010_0_0')==1 & strcmp(resx.test,'96_main')==1);
i11 = find(strcmp(resx.field,'x2010_0_0')==1 & strcmp(resx.test,'95_main')==1);
i12 = find(strcmp(resx.field,'x2010_0_0')==1 & strcmp(resx.test,'fto_main')==1);


is = [i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 i12];


h=figure; 

hs=[];



mcol = 'black';

for ii=1:length(is)
	hold on; 
	
	i = ii-1;	
	if (mod(i,3)==0) 
		colx = 'green';
	elseif (mod(i,3)==1)
		colx = 'red';
	elseif (mod(i,3)==2)
		colx = 'blue';
	end
	
	xpos = floor(i/3) + 0.2*mod(i,3);

	ix = is(ii);
	
	plot([xpos xpos], [resx.cil(ix) resx.ciu(ix)], '-', 'color', colx, 'LineWidth', 5);
	hold on; 


	if (rem(i,3)==0)
		h1=plot(xpos, resx.beta(ix), 'o', 'color', mcol, 'markersize', 10, 'MarkerFaceColor', mcol);
	elseif (rem(i,3)==1)
		h2=plot(xpos, resx.beta(ix), '*', 'color', mcol, 'markersize', 10, 'MarkerFaceColor', mcol);
	elseif (rem(i,3)==2)
		h3=plot(xpos, resx.beta(ix), '^', 'color', mcol, 'markersize', 10, 'MarkerFaceColor', mcol);
	end

end

%xlim([0.8 4.6]);
hold on;plot([0, 4], [0 0], '--');

set(gca, 'XTick',[0.2 1.2 2.2 3.4]);
set(gca,'XTickLabel',{'Nervous (1970)', 'Worrier (1980)', 'Tense/highly strung (1990)', 'Suffers from nerves (2010)'});

xlabel('Outcome variable');
ylabel('Beta');

%xtickangle(5)

legend([h1,h2,h3], {'96 SNP score'; '95 SNP score'; 'FTO SNP'});


saveas(h, strcat(resDir,'/nervous-followup/tsls-results.pdf'));
