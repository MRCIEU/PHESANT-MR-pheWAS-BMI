#!/bin/bash
#PBS -l walltime=12:00:00,nodes=1:ppn=16
#PBS -o output166tmp5-153-p4
#PBS -e errors166tmp5-153-p4
#PBS -t 301-455
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

pIdx=${PBS_ARRAYID}

Rscript genCorrelationstmp5.r 166 153 $pIdx

date

