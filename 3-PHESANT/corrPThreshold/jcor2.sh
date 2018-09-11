#!/bin/bash
#PBS -l walltime=100:00:00,nodes=1:ppn=16
#PBS -o output
#PBS -e errors
#PBS -t 101-200
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

pIdx=${PBS_ARRAYID}
np=200

Rscript genCorrelations.r $pIdx

date


