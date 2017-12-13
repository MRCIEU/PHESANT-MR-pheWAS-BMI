#!/bin/bash
#PBS -l walltime=4:00:00,nodes=1:ppn=16
#PBS -o output-score.file
#---------------------------------------------

date

module add apps/matlab-r2015a

cd $PBS_O_WORKDIR


# make score
matlab -r generate_snp_score96


# Add header line to SNP score file
snpDir="${HOME}/2016-biobank-mr-phewas-bmi/data/snps/"
sed -i '1s/^/userId, snpScore96\n/' ${snpDir}snp-score96.txt


# Add phenotype IDs to SNP score file - the user IDs in the genetic data files will be different to the user IDs in the phenotype file, so we use a bridging file supplied by UK Biobank to map between them.
matlab -r 'mapIds'


date


