
# Make follow-up dataset

## 1) Extract phenotypes required for follow-up analyses

We extract the following phenotypes, needed for our follow-up analyses:

- BMI, field ID [21001](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=21001)
- Nervous feelings, field ID [1970](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=1970)
- Worrier / anxious feelings, field ID [1980](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=1980)
- Suffering from nerves, field ID [2010](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=2010)
- Tense / highly strung, field ID [1990](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=1990)
- Seen a psychiatrist for nerves, anxiety, tension or depression, field ID [2100](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=2100)
- Seen doctor (GP) for nerves, anxiety, tension or depression [2090](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=2090)
- Frequency of tenseness / restlessness in last 2 weeks [2070](http://biobank.ctsu.ox.ac.uk/showcase/field.cgi?id=2070)

```bash
sh extractphenotypes.sh
```


## 2) Create file with SNPs and BMI genetic risk score required for follow-up analyses

Two-sample MR use the individual SNP effects, and one-sample MR uses the genetic risk score.
We first make a data file containing both of these:

```bash
matlab -r extractsnps
```

We then add the phenotype ID's to this file, using the mapping between the genetic and phenotype participant IDs:

```bash
qsub jmapids.sh
```

## 3) Combine phenotype and SNP data

We generate a data file, used for the two-sample and one-sample approaches:

```bash
Rscript combineData.r 
```

We also generate a data file used for our replication analysis, that includes an indicator variable denoting which participants
are in our discovery sample (the initial 150K sample using in the [PHESANT paper](https://academic.oup.com/ije/article/4347232/Software-Application-Profile-PHESANT-a-tool-for),
or the replication sample (the new set of participants that are not related to any participants in the discovery sample).

```bash
Rscript combineDataReplication.r
```



