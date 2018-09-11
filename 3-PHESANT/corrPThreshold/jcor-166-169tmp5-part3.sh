#!/bin/bash
#PBS -l walltime=2:00:00,nodes=1:ppn=16
#PBS -o output166tmp5-169-p3
#PBS -e errors166tmp5-169-p3
#PBS -t 201-300
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

pIdx=${PBS_ARRAYID}

Rscript genCorrelationstmp5.r 166 169 $pIdx

date


