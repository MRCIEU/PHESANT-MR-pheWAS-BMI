#!/bin/bash
#PBS -l walltime=5:00:00,nodes=1:ppn=16
#PBS -o outputphenospd
#PBS -e errorsphenospd
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR


cordir="${HOME}/2016-biobank-mr-phewas-bmi/data/sample500/phenotypes/derived/phesant-save/correlations/"

cd "${HOME}/code/PhenoSpD/"

Rscript script/phenospd.r --phenocorr ${cordir}cor-all-nona.txt --out ${cordir}phenospd-out.txt

date


