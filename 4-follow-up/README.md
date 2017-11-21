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


## 4) format results for table in paper

```bash
for i=1:size(d,1) fprintf('%s, %s, %.3f [%.3f, %.3f] \n', char(cellstr(d(i,1))), char(cellstr(d(i,2))), double(d(i,3)), double(d(i,4)), double(d(i,5))); end
```



## 5) Psycho-social category QQ plot


Extract results for this category:
```bash
sh categoryQQPlotData.sh
```

Make QQ plot:
```bash
Rscript categoryQQPlot.r
```
