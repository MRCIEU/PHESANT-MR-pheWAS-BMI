
dataDir=getenv('PROJECT_DATA');

mydir=strcat(dataDir,'/snps/');
qcdir = strcat(dataDir,'/qc/');

snpScore=dataset('file',strcat(mydir,'snp-score97-withPhenIds.csv'),'delimiter',',');

size(snpScore)

%%
% sex mismatch
sexMisMatch=dlmread(strcat(qcdir,'sexmismatch.txt'));
[C,ia] = setdiff(double(snpScore.app8786), sexMisMatch(:,1));
diff = size(snpScore,1)-size(ia,1);
fprintf('Sex mismatch removed: %d \n', diff);
snpScore = snpScore(ia,:);

size(snpScore)


%%
% putative sex chromosome aneuploidy
sexAneu=dlmread(strcat(qcdir,'aneiplody.txt'));
[C,ia] = setdiff(double(snpScore.app8786), sexAneu(:,1));
diff = size(snpScore,1)-size(ia,1);
fprintf('Sex aneuploidy removed: %d \n', diff);
snpScore = snpScore(ia,:);

size(snpScore)


%%
% outliers in heterozygosity and missing rates
outliers=dlmread(strcat(qcdir,'hetoutliers.txt'));
[C,ia] = setdiff(double(snpScore.app8786), outliers(:,1));
diff = size(snpScore,1)-size(ia,1);
fprintf('Outliers removed: %d \n', diff);
snpScore = snpScore(ia,:);
size(snpScore)


%%
% non europeans
noneuro=dlmread(strcat(qcdir, 'whitebritish.txt'));
[C,ia] = setdiff(double(snpScore.app8786), noneuro(:,1));
diff = size(snpScore,1)-size(ia,1);
fprintf('Non-euro removed: %d \n', diff);
snpScore = snpScore(ia,:);

size(snpScore)


%%
% relateds
relateds=dlmread(strcat(qcdir, 'relateds.txt'));
[C,ia] = setdiff(double(snpScore.app8786), relateds(:,1));
diff = size(snpScore,1)-size(ia,1);
fprintf('Relateds removed: %d \n', diff);
snpScore = snpScore(ia,:);

size(snpScore)


%%
% withdrawn consent
withdrawnFile=strcat(dataDir,'/participants-withdrawn.txt');
withDrawnConsent=dlmread(withdrawnFile);
[C,ia] = setdiff(double(snpScore.eid), withDrawnConsent);
diff = size(snpScore,1)-size(ia,1);
fprintf('Withdrawn consent removed: %d \n', diff);
snpScore = snpScore(ia,:);

size(snpScore)


export(snpScore, 'file',strcat(mydir,'snp-score97-withPhenIds-subset.csv'),'delimiter',',');





