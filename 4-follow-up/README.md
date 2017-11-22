# Follow-up analysis from MR-pheWAS of BMI

Required modules:

```bash
module add languages/R-3.3.1-ATLAS
module add apps/stata14
module add apps/matlab-r2015a
````


## 1) Make dataset for this follow-up analysis

See `make-dataset` subdirectory.

## 2) Two-stage least squares IV analysis

In `tsls` subdirectory.

## 2SLS in Stata
```bash
stata -b tslsAll.do
stata -b resultsToCsv.do
```

## plot 2SLS results
```bash
matlab -r plot2sls
```


## Conditional analysis, restricting to participants who did not report as a nervous person (FID=1980)
```bash
stata -b tslsAllConditioned1970.do
stata -b resultsToCsvConditional.do
```



## 3) MR-Egger analysis

In `twosample-mr` subdirectory.

a) Generate test statistics needed for MR-Egger

```bash
Rscript assocForEggerAll.r
```

b) Run MR-Egger
```bash
Rscript runMREggerAll.r
```

c) Plot MR-Egger results

```bash
matlab -r plotEggerAll
```


## 4) Psycho-social category QQ plot


Extract results for this category:
```bash
sh categoryQQPlotData.sh
```

Make QQ plot:
```bash
Rscript categoryQQPlot.r
```
