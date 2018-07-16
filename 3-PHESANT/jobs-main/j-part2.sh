#!/bin/bash
#PBS -l walltime=360:00:00,nodes=1:ppn=1
#PBS -o output
#PBS -e errors
#PBS -t 101-200
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

dataDir="${HOME}/2016-biobank-mr-phewas-bmi/data/sample500/"

codeDir="${PHESANT}/WAS/"
varListDir="${PHESANT}/variable-info/"

outcomeFile="${dataDir}phenotypes/derived/data.11148-phesant_header.csv"
expFile="${dataDir}snps/snp-score97-withPhenIds-subset.csv"
varListFile="${varListDir}outcome-info.tsv"
dcFile="${varListDir}data-coding-ordinal-info.txt"

# start and end index of phenotypes
pIdx=${PBS_ARRAYID}
np=200

# confounders
confFile="${dataDir}phenotypes/derived/confounders-PHESANT-pcs.csv"

resDir="${HOME}/2016-biobank-mr-phewas-bmi/results/sample500k/results-PHESANT-main/"

# run PHESANT
cd $codeDir
Rscript ${codeDir}phenomeScan.r --partIdx=$pIdx --numParts=$np --phenofile=${outcomeFile} --traitofinterestfile=${expFile} --variablelistfile=${varListFile} --datacodingfile=${dcFile} --traitofinterest="snpScore97" --resDir=${resDir} --userId="eid" --confounderfile=${confFile}



date


