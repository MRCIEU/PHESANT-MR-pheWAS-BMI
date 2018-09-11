#!/bin/bash
#PBS -l walltime=5:00:00,nodes=1:ppn=16
#PBS -o output-check
#PBS -e errors-check
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

Rscript checkCorrelationMatrix.r

date


