
# Restrict sample - QC and withdrawn consent


## Generate files of exclusions from QC

We generate lists of excluded participants, where each list uses one of the following criteria:

1. Sex mismatch
2. Putative sex chromosom aneiploidy
3. Outliers in heterozygosity and and missing rates
4. Not of white British ancestry
5. Related to another participant (up to third degree)

```bash
module add languages/R-3.3.1-ATLAS
Rscript processUKBQCFile.r
```

## Create a new genetic score data file with only the participants included in our sample

We remove all participants with genetic data not passing QC, or who have withdrawn their consent.

```bash
module add apps/matlab-r2015a
matlab -r "doGenerateIncludedSample"
```
