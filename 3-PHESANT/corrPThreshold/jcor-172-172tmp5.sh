#!/bin/bash
#PBS -l walltime=2:00:00,nodes=1:ppn=1
#PBS -o output172tmp5-172
#PBS -e errors172tmp5-172
#PBS -t 1-46
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

pIdx=${PBS_ARRAYID}

Rscript genCorrelationstmp5.r 172 172 $pIdx

date


