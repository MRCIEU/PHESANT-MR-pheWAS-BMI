


# 1) Extract phenotypes

See code in extractphenotypes.sh

# 2) Extract SNPs and add phenotype IDs

```bash
matlab -r extractsnps
```

```bash
qsub jmapids.sh
```

# 3) Combine phenotype and SNP data

```bash
Rscript combineData.r 
```
