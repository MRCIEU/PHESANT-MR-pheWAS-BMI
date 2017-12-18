

# Running PHESANT with the full 500K UK Biobank dataset




## 1. Running our main PHESANT MR-pheWAS analysis

We use 200 jobs on [Blue Crystal](https://www.acrc.bris.ac.uk/acrc/phase3.htm), to run the phenome scan in 200 parts.

The job files are created using:

```bash
cd jobs-main-noCIs/
sh makejobs.sh
```

We then run the jobs on Blue Crystal using:

```bash
sh runjobs.sh
```


## 2. Processing the PHESANT results


a) PHESANT results processing

We run the results processing code in PHESANT (described in the PHESANT GitHub repository):

```bash
cd resultsProcessing/
sh resultsProcessing.sh
```

b) Generating PHESANT-viz visualisation

We generate the JSON required for the PHESANT-viz D3 visualisation:

```bash
sh generatePHESANTviz.sh
```


## 3. Run sensitivity analysis

Our sensitivity MR-pheWAS analysis is the same as our main MR-pheWAS, except that we adjust additionally for assessment centre and genetic batch.

We make and run the blue crystal jobs using:

```bash
cd jobs-sensitivity/
sh makejobs.sh
sh runjobs.sh
```

Then process the results using:

```bash
cd resultsProcessing/
sh resultsProcessing-sensitivity.sh
```


## 4. Compare sensitivity results with main analysis

To compare the results of our main MR-pheWAS with the results of our sensitivity MR-pheWAS, we first combine these results into a single results file:

```bash
cd compareSensitivity/
Rscript combineResults.r
```

We then plot the P values of these MR-pheWAS against each other (on the log scale), to identify any large changes in results (in terms of association strength):

```bash
matlab -r plotCompareSensitivity
```

We list the results that have a low P value in our sensitivity analysis (P<bonferroni corrected threshold) but are null (P>0.05) in our main analysis:

```bash
cat ${RES_DIR}/results-compare-main-sensitivity.txt | awk -F, '($2 > 5e-2 && $3 < 2.44e-6) {print $0}' | grep -v ',$' | sed 's/,/\t/g' 
```


## 5. Results for supplementary table

This is the list for Supplementary table 4, containing results with P value less than 5% FDR threshold:

```bash
cat ${RES_DIR}/results-PHESANT-main-noCIs/results-combined.txt | grep -v 'varName' | awk -F'\t' '($10=="")' | head -n 519 | awk -F'\t' '{printf "%s \t %.2e \t %.2e \t %s \t %s \n", $1, $4, $7, $8, $9}'
```

This script generates the supplementary data file containing the results of all tests in the MR-pheWAS:

```bash
sh genSupplementResultsList.sh
```

