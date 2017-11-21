
# Restrict sample - QC and withdrawn consent


## Generate files of exclusions from QC

```bash
module add languages/R-3.3.1-ATLAS
Rscript processUKBQCFile.r
```

## Create a new genetic score data file with only the participants included in our sample

This code removes all participants with genetic data not passing QC, or who have withdrawn their consent.

```bash
module add apps/matlab-r2015a
matlab -r "doGenerateIncludedSample"
```
