#!/bin/bash
#PBS -l walltime=4:00:00,nodes=1:ppn=1
#PBS -o output-map.file
#---------------------------------------------

date

module add apps/matlab-r2015a

cd $PBS_O_WORKDIR

matlab -r mapIds

date


