

# Running PHESANT with the full 500K UK Biobank dataset




## 1. Generate Blue Crystal job files and then run PHESANT

We use 40 jobs on Blue Crystal, to run the phenome scan in 40 sub-parts. 

The job files are created using:

```bash
cd jobs/
sh makejobs.sh
```

We then run the jobs on Blue Crystal using:

```bash
sh runjobs.sh
```

Note that the job files are set to have walltime of 60 hours, but most of the jobs finish much quicker.

## 2. Process the PHESANT results

Results processing:

 ```bash
 sh resultsProcessing.sh
 ```

Generate PHESANT-viz visualisation:

 ```bash
 sh generatePHESANTviz.sh
 ```

Generate results listing for supplementary data file:

 ```bash
 sh genResultsList.sh
 ```



## 3. Run sensitivity analysis

This is the same as the main analysis but adjusts for the first 10 principal components, and assessment centre (as well as age, sex and genotype chip).

Make and run the blue crystal jobs using:

```bash
cd jobs-sensitivity/
sh makejobs.sh
sh runjobs.sh
```

Then process the results using:

```bash
sh resultsProcessingSensitivity.sh
sh generatePHESANTvizSensitivity.sh
sh genResultsListSensitivity.sh
```


## 4. Compare sensitivity results with main analysis

```bash
cd compareSensitivity/
Rscript combineResults.r
matlab -r plotCompareSensitivity
```

List of results with low p value in sensitivity analysis but null in main analysis:

```bash
cat ${RES_DIR}/results-compare-main-sensitivity.txt | awk -F, '($2 > 5e-2 && $3 < 2.44e-6) {print $0}' | grep -v ',$' | sed 's/,/\t/g' 
```


## 5. Results for supplementary table


This is the list for Supplementary table 4, containing results with P value less than 5% FDR threshold:

```bash
cat ${RES_DIR}/results-PHESANT-main-noCIs/results-combined.txt | grep -v 'varName' | awk -F'\t' '($10=="")' | head -n 519 | awk -F'\t' '{printf "%s \t %.2e \t %.2e \t %s \t %s \n", $1, $4, $7, $8, $9}'
```

This is the supplementary data file containing the results of all tests in the MR-pheWAS:

```bash
sh genSupplementResultsList.sh
```

