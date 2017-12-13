

# Generating confounder files

This code generates two confounders files:

1. confounders-PHESANT-pcs.csv - for main analysis, adjusting for age, sex and the first 10 principal components.
2. confounders-PHESANT-sensitivity.csv - for sensitivity analysis, additionally adjusting for assessment centre and genetic batch.


## Make file containing phenotypic confounders

Find the column numbers of each confounder variable in the phenotype file:

```bash
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'eid'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x31_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x21022_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x54_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x22000_'
```

Extract the confounders from the phenotypes file, using the column indexes for the fields we need:

```bash
cut -d',' -f 1,9,33,6620,6621 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv > ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header-confounders.csv
```


## 3. Make confounder file containing all confounders

We generate a data file containing all confounders we use across our different analysis. This includes:

1. Age and sex
2. First 40 genetic principal components
3. Assessment centre
2. Genetic batch

```bash
module add languages/R-3.3.1-ATLAS
Rscript makeConfounderFiles.r
```


## 4. Prepare confounders for particular analyses

From the file generated in step 3, we generate files containing subsets for different analyses.

a)  Main analysis: age, sex, and first 10 genetic principal components:

```bash
cut -d, -f1-13 ${PROJECT_DATA}/phenotypes/derived/confounders-PHESANT-sensitivity-40pcs.csv > ${PROJECT_DATA}/phenotypes/derived/confounders-PHESANT-pcs.csv
```

b) Sensitivity analysis: age, sex, first 10 genetic principal components, assessment centre and genetic batch:

```bash
cut -d, -f1-13,44- ${PROJECT_DATA}/phenotypes/derived/confounders-PHESANT-sensitivity-40pcs.csv > ${PROJECT_DATA}/phenotypes/derived/confounders-PHESANT-sensitivity.csv
```

Sensitivity analysis in follow-up on nervousness: age, sex and first 40 genetic principal components:

```bash
cut -d, -f1-43 ${PROJECT_DATA}/phenotypes/derived/confounders-PHESANT-sensitivity-40pcs.csv > ${PROJECT_DATA}/phenotypes/derived/confounders-PHESANT-followup-pcs40.csv
```


