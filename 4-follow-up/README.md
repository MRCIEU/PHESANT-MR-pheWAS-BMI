# Follow-up analysis from MR-pheWAS of BMI

We follow-up a set of psychosocial phenotypes, identified from the MR-pheWAS analysis.

## 1) Make dataset for this follow-up analysis

See `make-dataset` subdirectory.


## 2) Estimating the causal effect of BMI

We use two-stage IV probit regression to estimate the effect of BMI on our identified nervousness/anxiety traits.

a) Running our 2SLS analysis

We first generate a Stata dta file containing the results, and then convert this file to CSV.

```bash
cd tsls/
stata -b tslsAll.do
stata -b resultsToCSV.do
```

b) Plotting our 2SLS results

```bash
matlab -r plot2sls
```


## 3) Sensitivity analyses

We use three alternative approaches to IV probit regression, that estimate the causal effect of BMI under more relaxed assumptions of instrument validity:

a) MR-Egger
b) Weighted median
c) Mode-based estimator

In `twosample-mr` subdirectory we:

a) Generate test statistics needed for MR-Egger:

```bash
Rscript assocForEggerAll.r
```

b) Run our two-sample analyses:

```bash
Rscript runMREggerAll.r
```

c) Plot our two-sample results:

```bash
matlab -r plotEggerAll
```


## 4) Replication analysis

We run TSLS using:

- The subsample of the IJE PHESANT paper (our discovery sample).
- The subsample of particpants in the new subset, who are not related to participants in the discovery sample (our replication sample).

Our 2SLS replication analysis is run using:

```bash
stata -b tslsAllReplication.do
stata -b resultsToCsvReplication.do
```


## 5) Psychosocial category QQ plot

We generate a QQ plot that includes only psychosocial phenotypes.

In the `qqByCategory` directory we:

a) Extract results for the UK Biobank psychosocial field category, with ID [100059](http://biobank.ctsu.ox.ac.uk/showcase/label.cgi?id=100059):

```bash
sh categoryQQPlotData.sh
```

b) Make a QQ plot for this subset of our PHESANT results:

```bash
Rscript categoryQQPlot.r
```

## 6) Psychosocial phenotype correlations

We generate contingency tables for each pairing of psychosocial trait, to see how consistent these phenotypes are.

```bash
stata -b tabulateNervousPhenos.do
````

## 7) Assessing population stratification

We test whether adjusting for genetic principal components sufficiently accounts for confounding via population stratification.

We also test whether the direction of association of attending Bristol and Glasgow assessment centres with the BMI genetic score, 
are in the direction we would expect, if these associations are due to population stratification.

```bash
Rscript testPopulationStratification.r
```

## 8) Proof of principle association

a) 
```bash
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'eid'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep '2443'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep '20002'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x135_'
```


b) Extract columns
```bash
cut -d',' -f 1,293,855,4219-4247 ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header.csv > ${PROJECT_DATA}/phenotypes/derived/data.11148-phesant_header-proofofprinciple.csv
```


## 9) Basic comparison between groups of nervousness phenotypes (yes vs no)

a) Find columns for: eid, townsend deprivation index, BMI, depression, age, sex, smoking status, 4 nervous phenos

```bash
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'eid'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x189_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x21001_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x4598_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x21022_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x31_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x20116_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x1970_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x1980_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x1990_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x2010_'
head -n 1 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv | sed 's/,/\n/g' | cat -n | grep 'x845_'
```

b) Extract columns
```bash
cut -d',' -f 1,304,7062,1858,7075,9,6360,823,826,829,835,532 ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv > ${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header-summarycharacterisics.csv
```


