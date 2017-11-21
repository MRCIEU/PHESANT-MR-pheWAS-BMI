homeDir=getenv('HOME');

dataDir=strcat(homeDir,'/2016-biobank-mr-phewas-bmi/data/sample500/');

bridge = dataset('file',strcat(dataDir,'bridging/ukb7341.enc_ukb'),'delimiter',',');
snpscore = dataset('file',strcat(dataDir, 'snps/nervousness-snps.txt'),'delimiter',',');

% sort snp scores by user id 
[~,i] = sort(double(snpscore(:,1)));
snpscoreSort = snpscore(i,:);

% match up the ids
[~,iSnp,iPhen] = intersect(double(snpscoreSort(:,1)),double(bridge(:,2)));
combined = [bridge(iPhen,:) snpscoreSort(iSnp,:)];                

% check
format long
combined(1:10,:)

% change app16729 column to eid, to match id name in phenotype file
combined.Properties.VarNames{1} = 'eid';

export(combined,'file', strcat(dataDir, 'snps/nervousness-snps-withPhenIds.csv'), 'delimiter',',');
