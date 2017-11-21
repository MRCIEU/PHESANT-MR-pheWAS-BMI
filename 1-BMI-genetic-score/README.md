
# SNP pre-processing and creating a genetic score

The code in this directory extracts SNPs from the UK Biobank genetic data and then uses these to generate a genetic score (weighted by the effect size of each SNP on BMI)

After the following steps, the file `snp-score96-withPhenIds-subset.csv` contains the genetic risk score for the participants included in our sample (after QC).

## 1. Retrieve the correct SNPs from Biobank main data

```bash
cd retrieve-snps/jobs/
sh runjobs.sh
```

## 2. Process GEN file
```bash
cd process-snps/
sh processGenFiles.sh
```

## 3. Generate BMI genetic score

The script file calculates the weighted sum of the allele dosages, weighted by the effect size (as in Locke paper)

```bash
cd generate-score/
qsub jscore.sh
```

## 4. Remove excluded participants (QC)

```bash
cd exclusions/
module add apps/matlab-r2015a
matlab -r doGenerateIncludedSample
```


## 5. Remove intermediate files

```bash
snpDir="${PROJECT_DATA}/snps/"
rm ${snpDir}snp-score96.txt
rm ${snpDir}snps-all-expected2.txt
rm ${snpDir}snps-all-expected.txt
rm ${snpDir}snp-data.txt
rm ${snpDir}snp-names.txt
rm ${snpDir}userIds.txt
rm ${snpDir}snps-all-expected2-transposed.txt
rm ${snpDir}snp-score96-withPhenIds.csv
```
