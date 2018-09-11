#!/bin/bash
#PBS -l walltime=5:00:00,nodes=1:ppn=16
#PBS -o output169tmp5-169-p3
#PBS -e errors169tmp5-169-p3
#PBS -t 201-300
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

pIdx=${PBS_ARRAYID}

Rscript genCorrelationstmp5.r 169 169 $pIdx

date


