* apps/stata14


local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

* results file setup
tempname memhold
postfile `memhold' str60 field str60 test estimate lower upper  using "`resDir'/nervous-followup/nervous-results-conditional.dta" , replace


**
** load and prepare data

insheet using "`dataDir'/phenotypes/derived/nervous-dataset.csv", clear

keep if x1970_0_0 == 0

rename x31_0_0 sex
rename x21022_0_0 age

* standardise scores
summ snpscore96
egen snpscore96std = std(snpscore96)
replace snpscore96 = snpscore96std

summ


*****
***** INSTRUMENT STRENGTH

log using "`resDir'/nervous-followup/nervous-results-conditional-fstats.log", text replace

summ 

****
**** f statistics

regress x21001_0_0 snpscore96

regress x21001_0_0 rs1558902

regress x21001_0_0 snpscore95

log close



do tslsConditioned1970 "x1980_0_0" `memhold'

do tslsConditioned1970 "x1990_0_0" `memhold'

do tslsConditioned1970 "x2010_0_0" `memhold'


postclose `memhold' 

exit, clear
