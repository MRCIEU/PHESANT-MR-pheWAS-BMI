#!/bin/bash
#PBS -l walltime=10:00:00,nodes=1:ppn=1
#PBS -o output-worry-boots.file
#---------------------------------------------

date

cd $PBS_O_WORKDIR

module add apps/stata14

stata -b worryScoreBoots.do

date



