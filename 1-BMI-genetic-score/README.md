
# SNP pre-processing and creating a genetic score

The code in this directory extracts SNPs from the UK Biobank genetic data and then uses these to generate a genetic score (weighted by the effect size of each SNP on BMI).

The following steps will create the file `snp-score96-withPhenIds-subset.csv` containing the genetic risk score for the participants included in our sample (after QC).


## a) Retrieve the correct SNPs from UK Biobank data

We first make a job file for each chromosome using the template file `j-template.sh`. 

```bash
cd retrieve-snps/jobs/
sh makejobs.sh
```

Each job will extract the SNPs listed in `retrieve-snps/snps-96.txt`, that are located on the specified chromosome.
We run each of these jobs using:

```bash
sh runjobs.sh
```


## b) Create dosage data from the gen format

The GEN format output from step *a* has one SNP per line.
Each line has some columns that describe the SNP e.g what chromosome it is on and the alleles (A and B), and 3 columns per person, the probability a participant has a particular genotype (i.e. AA, AB and BB).
The order of participants in this genotype file matches the order of the participants in the sample files.

We now convert this format into dosages, i.e. the number of B alleles each participant has 
(strictly this is the expected value of the number of B alleles, because we are dealing with probabilities).

Our conversion script does the following:

1. Calculates the dosages - each column is then the dosage for each participant.
2. Adapts the format from column-wise to row-wise.
3. Adds user ID column.

```bash
cd process-snps/
sh processGenFiles.sh
```


## c) Generate BMI genetic score

We calculate the weighted sum of the allele dosages, weighted by the effect size (as in Locke paper).
Also, we use the ID mapping file, that contains the mapping between the genetic participant IDs and the phenotype participant IDs, to add the phenotype IDs to this data file.

```bash
cd generate-score/
qsub jscore.sh
```

## d) Remove excluded participants (QC)

See `exclusions` subdirectory.


## e) Remove intermediate files

We remove intermediate files that were created during the above process but are no longer needed.

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
rm ${snpDir}snps-out*.gen
```
