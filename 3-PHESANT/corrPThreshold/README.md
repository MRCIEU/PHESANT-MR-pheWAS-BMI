


## Less stringent threshold using phenotype correlations


This uses the phenotype data generated using PHESANT with the save option (see `../jobs-save/').

Using the PHESANT derived data we can generate phenotype correlations, with the following steps.


### 1. Correlate each phenotype with each other phenotype.


Linear, binary and ordered phenotypes can be correlated with spearmans rank correlation.

Correlation cannot be obtained for unordered categorical phenotypes, so these are given conservative estimates of 0 (no correlation) against all other phenotypes.


## Splitting into parts

```bash
head -n1 ${PROJECT_DATA}/phenotypes/derived/phesant-save/data-binary-71-200.txt | awk -F, '{print NF}'
head -n1 ${PROJECT_DATA}/phenotypes/derived/phesant-save/data-binary-153-200.txt | awk -F, '{print NF}'
head -n1 ${PROJECT_DATA}/phenotypes/derived/phesant-save/data-binary-166-200.txt | awk -F, '{print NF}'
head -n1 ${PROJECT_DATA}/phenotypes/derived/phesant-save/data-binary-169-200.txt | awk -F, '{print NF}'
head -n1 ${PROJECT_DATA}/phenotypes/derived/phesant-save/data-binary-172-200.txt | awk -F, '{print NF}'
```

Part 71 has 1531 variables, 153 has 3314 variables, 159 has 4125 variables, 166 has 4544 variables, 169 has 3020 variables, 172 has 457 variables



```bash
qsub jcorr1.sh
qsub jcorr2.sh
```


Larger part combinations are broken up into smaller chunks. Run all the jcor-*-part*.sh jobs also. 




### 2. Collating correlations

After calculating correlations in parallel we need to collate them in to a single matrix for PhenoSpD to use.

First we collate sets of rows:
```bash
Rscript collateMatrices.r
```

Each set of rows should have 22879 columns - this is the total number of continuous, binary and cat ord phenotypes.


Then we join each of these row sets together:
```bash
joinRows.sh
```

The correlation matrix has 22879 rows and 22879 cols - this is the total number of continuous, binary and cat ord phenotypes.

Some rows have NA values where there are no overlapping examples, so we replace them with zeros. And we remove quotes.

```bash
cordir="${PROJECT_DATA}/phenotypes/derived/phesant-save/correlations/"
sed 's/       NA/0/g' ${cordir}cor-all.txt > ${cordir}cor-all-nona.txt
sed -i 's/\"//g' ${cordir}cor-all-nona.txt
sed -i 's/ //g' ${cordir}cor-all-nona.txt
```

### 3. Checking correlation matrix


```bash
qsub jcheckcors.sh 
```


### 4. Calculate the number of independent tests.

The number of independent tests is calculated using spectral decomposition.

```bash
qsub jphenospd.sh
```


