
homeDir=getenv('HOME');
dir = strcat(homeDir,'/2016-biobank-mr-phewas-bmi/data/');

bridge = dataset('file',strcat(dir,'sample500/bridging/ukb7341.enc_ukb'),'delimiter',',');
snpscore = dataset('file',strcat(dir,'sample500/snps/snp-score97.txt'),'delimiter',',');

% sort snp scores by user id 
[~,i] = sort(double(snpscore(:,1)));
snpscoreSort = snpscore(i,:);

% match up the ids
%[~,iSnp,iPhen] = intersect(double(snpscoreSort(:,1)),double(bridge(:,2)));
%combined = [bridge(iPhen,:) snpscoreSort(iSnp,:)];                


combined = join(bridge, snpscoreSort, 'LeftKeys', 'app8786', 'RightKeys', 'userId', 'type', 'rightouter');


% check
format long
%combined(1:10,:)                                  

% change app16729 column to eid, to match id name in phenotype file
combined.Properties.VarNames{1} = 'eid';

export(combined,'file', strcat(dir,'sample500/snps/snp-score97-withPhenIds.csv'), 'delimiter', ',');
