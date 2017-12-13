
# MR-pheWAS of BMI using PHESANT

This repository accompanies the paper:

Millard, LAC, et al. Searching for the causal effects of body mass index in circa 330 000 people in UK Biobank (2017). submitted.

## Environment details

I use the following language versions: R-3.3.1-ATLAS, State v14, and Matlab-r2015a. I use [PHESANT](https://github.com/MRCIEU/PHESANT) v0.10.

The code uses some environment variables, which needs to be set in your linux environment. I set some permanently (that I'll use across projects), and some temporarily, that are relevant to just this project.

I set the results directory and project data directory temporarily with:
```bash
export RES_DIR="${HOME}/2016-biobank-mr-phewas-bmi/results/sample500k"
export PROJECT_DATA="${HOME}/2016-biobank-mr-phewas-bmi/data/sample500"
```

I set the IEU shared UKB data directory, and the PHESANT code directory (i.e. my path to the code from the PHESANT git repository) permanently, by adding the following to my `~/.bash_profile` file.

```bash
export UKB_DATA="/path/to/ukb/data"
export PHESANT="/path/to/phesant/package"
```


## Phenotype data formatting

Rename phenotypes to correct format in phenotype file column header.

These commands add a 'x' to the start of each phenotype and replaces '.' and '-' characters with '_' in the column headers of the phenotype file.

```bash
datadir="${PROJECT_DATA}/phenotypes/derived/"
origdir="${PROJECT_DATA}/phenotypes/original/"
head -n 1 ${origdir}data.11148.csv | sed 's/,"/,"x/g' | sed 's/-/_/g' | sed 's/\./_/g' > ${datadir}data.11148-phesant_header.csv
awk '(NR>1) {print $0}' ${origdir}data.11148.csv >> ${datadir}data.11148-phesant_header.csv
```



## Analysis overview

We perform a Mendelian randomization phenome-wide association study (MR-pheWAS) of BMI, using a BMI genetic score (on the full UKB sample).

The MR-pheWAS is performed using (PHESANT)[https://github.com/MRCIEU/PHESANT].


### Analysis components

There are 4 main steps:

1. Data preprocessing

See `1-BMI-genetic-score` directory.

2. Generating confounder file

See `2-confounder-files` directory.

3. Running PHESANT

See `3-PHESANT` directory.

4. Follow-up analyses

See `4-follow-up' directory.


### Directory structures

The results directory has the following structure:

```
results-PHESANT-sensitivity-pcs-assesscentre-geneticbatch-merged-noCIs/
results-PHESANT-sensitivity-pcs-assesscentre-geneticbatch-noCIs/
results-PHESANT-sensitivity-pcs-noCIs/
nervous-followup/
```

The data directory has the following structure and files:

```
phenotypes/derived/
phenotypes/original/
snps/derived/
qc/
participants-withdrawn.txt
```


