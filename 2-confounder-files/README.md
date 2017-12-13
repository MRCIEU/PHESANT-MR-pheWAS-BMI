

# Generating data files containing covariates

We generate a data file containing all covariates needed for our study (steps 1 and 2), 
and then extract subset of these into other covariate data files that are required for different analyses (step 3).


## 1. Make file containing all phenotypic covariates

Phenotypic covariates are:

- Age at recruitment, field id [21022](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=21022).
- Sex, field id [31](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=31).
- Assessment centre, field id [54](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=54).
- Genotype measurement batch, field id [22000](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=22000).

a) Find the column numbers of each covariate variable in the phenotype file:

```bash
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'eid'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x31_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x21022_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x54_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x22000_'
```

b) Extract the covariates from the phenotypes file, using the column indexes for the fields we need:

```bash
cut -d',' -f 1,9,33,6620,6621 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv > ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header-confounders.csv
```


## 2. Make covariate file containing all covariates (genetic and phenotypic)

We generate a data file containing all confounders we use across our different analysis. This includes:

1. Age and sex
2. First 40 genetic principal components
3. Assessment centre
2. Genetic batch

We combine the covariate file created in step 1, with the 40 genetic principal components:

```bash
module add languages/R-3.3.1-ATLAS
Rscript makeConfounderFiles.r
```


## 3. Prepare sets of covariates needed for particular analyses

From the file generated in step 3, we generate 3 data files containing subsets for different analyses.

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


