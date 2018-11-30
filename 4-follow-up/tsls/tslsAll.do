* apps/stata14

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

* results file setup
tempname memhold
postfile `memhold' str60 field str60 test estimate lower upper  using "`resDir'/results-21753/nervous-followup/nervous-results.dta" , replace


**
** load and prepare data

insheet using "`dataDir'/phenotypes/derived/nervous-dataset97.csv", clear

summ x21001_0_0

rename x31_0_0 sex
rename x21022_0_0 age

summ sex
summ age

* standardise scores

summ snpscore97
summ snpscore96

egen snpscore97std = std(snpscore97)
egen snpscore96std = std(snpscore96)

replace snpscore97 = snpscore97std
replace snpscore96 = snpscore96std

summ snpscore97
summ snpscore96

* standardised BMI
egen x21001_0_0std = std(x21001_0_0)

*log using "`resDir'/results-21753/nervous-followup/nervous-results-fstats.log", text replace

summ 


****
**** f statistics

*  f statistic of each genetic IV

regress x21001_0_0 snpscore97

regress x21001_0_0 rs1558902

regress x21001_0_0 snpscore96


*log close

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





****
**** worry score

replace x1970_0_0 = . if x1970_0_0<0
replace x1980_0_0 = . if x1980_0_0<0
replace x1990_0_0 = . if x1990_0_0<0
replace x2010_0_0 = . if x2010_0_0<0
gen worryscore = .
replace worryscore = x1970_0_0+x1980_0_0+x1990_0_0+x2010_0_0 if x1970_0_0!=. & x1980_0_0!=. & x1990_0_0!=. & x2010_0_0!=.

summ worryscore 
egen worryscoreSTD = std(worryscore)
summ worryscore*

histogram worryscoreSTD 
graph export "`resDir'/worryScoreHist.pdf", replace

tab worryscore

ologit worryscore snpscore97 age sex pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10,or

local beta _b[snpscore97]
local ciL _b[snpscore97] - 1.96 * _se[snpscore97]
local ciU _b[snpscore97] + 1.96 * _se[snpscore97]
post `memhold' ("`myvar'") ("97_main") (`beta') (`ciL') (`ciU')

post `memhold' ("worryscore") ("97_main_odds") (exp(`beta')) (exp(`ciL')) (exp(`ciU'))



****
****

postclose `memhold' 

exit, clear
