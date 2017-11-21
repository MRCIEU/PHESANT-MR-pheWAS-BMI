* apps/stata14

local myvar `1'

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

log using "`resDir'/nervous-followup/nervous-results`myvar'Conditioned1970.log", text replace

insheet using "`dataDir'/phenotypes/derived/nervous-dataset.csv", clear


keep if x1970_0_0 == 0

drop rs*

rename x31_0_0x x31_0_0
rename x21022_0_0x x21022_0_0

replace `myvar' = . if `myvar' ==-10
replace `myvar' = . if `myvar' ==-3 
replace `myvar' = . if `myvar' ==-1
tab `myvar'

summ x21001_0_0
count if x21001_0_0 =="NA"
replace x21001_0_0 = "-100" if x21001_0_0 =="NA"
destring x21001_0_0, replace
replace x21001_0_0 = . if x21001_0_0<0


rename x31_0_0 sex
rename x21022_0_0 age


* standardise scores

summ snpscore96
egen snpscore96std = std(snpscore96)
replace snpscore96 = snpscore96std



summ x21001_0_0
summ sex
summ age
summ snpscore96
summ `myvar'


*****
***** 10 PCs and 96 snp score

* 96 snp score 
ivprobit `myvar' age sex pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10 (x21001_0_0 = snpscore96), first


*****
***** 40 PCs and 96 snp score

ivprobit `myvar' age sex pc* (x21001_0_0 = snpscore96), first



*****
***** INSTRUMENT STRENGTH


* get the F statistic of each genetic IV
regress x21001_0_0 snpscore96



*****
***** OBSERVATIONAL ASSOCIATION

logistic `myvar' x21001_0_0 age sex

log close
