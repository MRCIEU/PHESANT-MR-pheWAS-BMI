#!/bin/bash
#PBS -l walltime=4:00:00,nodes=1:ppn=16
#PBS -o output-snpsCHR.file
#---------------------------------------------

date

module load languages/gcc-5.0
module load libraries/gnu_builds/gsl-1.16
module load apps/qctool-2.0

chr="CHR"

cd $PBS_O_WORKDIR

dir="${HOME}/2016-biobank-mr-phewas-bmi/data/sample500/snps/"

ddir="${UKB_DATA}/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/"
datadir="${ddir}dosage_bgen/"

sampleFile="${ddir}sample-stats/data.chr${chr}.sample"

qctool -g ${datadir}data.chr${chr}.bgen -incl-rsids snps-96.txt -s $sampleFile -og ${dir}snp-out${chr}.gen

date


