* apps/stata14

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

* results file setup
tempname memhold
postfile `memhold' str60 field str60 test estimate lower upper  using "`resDir'/nervous-followup/nervous-results.dta" , replace

* load data
insheet using "`dataDir'/phenotypes/derived/nervous-dataset.csv", clear

summ x21001_0_0
count if x21001_0_0 =="NA"
replace x21001_0_0 = "-100" if x21001_0_0 =="NA"
destring x21001_0_0, replace
replace x21001_0_0 = . if x21001_0_0<0

summ x21001_0_0

rename x31_0_0 sex
rename x21022_0_0 age

summ sex
summ age

* standardise scores

summ snpscore96
summ snpscore95

egen snpscore96std = std(snpscore96)
egen snpscore95std = std(snpscore95)

replace snpscore96 = snpscore96std
replace snpscore95 = snpscore95std

summ snpscore96
summ snpscore95

* standardised BMI
egen x21001_0_0std = std(x21001_0_0)


****
**** f statistics

*  f statistic of each genetic IV

regress x21001_0_0 snpscore96

regress x21001_0_0 rs1558902

regress x21001_0_0 snpscore95


****
**** tsls analysis of each nervousness trait

do tsls "x1970_0_0" `memhold'

do tsls "x1980_0_0" `memhold'

do tsls "x1990_0_0" `memhold'

do tsls "x2010_0_0" `memhold'


* other anxiety / nervous fields
do tsls "x2100_0_0" `memhold'
do tsls "x2090_0_0" `memhold'
do tslsContinuous "x2070_0_0" `memhold'




postclose `memhold' 

exit, clear
