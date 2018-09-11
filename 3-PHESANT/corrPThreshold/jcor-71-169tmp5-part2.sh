#!/bin/bash
#PBS -l walltime=5:00:00,nodes=1:ppn=16
#PBS -o output71tmp5-169-p2
#PBS -e errors71tmp5-169-p2
#PBS -t 101-160
#---------------------------------------------


module add languages/R-3.3.1-ATLAS

date

cd $PBS_O_WORKDIR

pIdx=${PBS_ARRAYID}

Rscript genCorrelationstmp5.r 71 169 $pIdx

date


