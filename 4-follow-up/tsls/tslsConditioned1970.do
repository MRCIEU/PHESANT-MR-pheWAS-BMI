* apps/stata14

local myvar `1'
local memhold `2'

local resDir : env RES_DIR

log using "`resDir'/nervous-followup/nervous-results`myvar'Conditioned1970.log", text replace


replace `myvar' = . if `myvar' ==-10
replace `myvar' = . if `myvar' ==-3 
replace `myvar' = . if `myvar' ==-1
tab `myvar'

summ `myvar'

*****
***** 10 PCs and 96 snp score

* 96 snp score 
ivprobit `myvar' age sex pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10 (x21001_0_0 = snpscore96), first

local beta _b[x21001_0_0]
local ciL _b[x21001_0_0] - 1.96 * _se[x21001_0_0]
local ciU _b[x21001_0_0] + 1.96 * _se[x21001_0_0]

post `memhold' ("`myvar'") ("96_main") (`beta') (`ciL') (`ciU')

post `memhold' ("`myvar'") ("96_main_odds") (exp(1.6*(`beta'))) (exp(1.6*(`ciL'))) (exp(1.6*(`ciU')))

*****
***** 40 PCs and 96 snp score

ivprobit `myvar' age sex pc* (x21001_0_0 = snpscore96), first

local beta _b[x21001_0_0]
local ciL _b[x21001_0_0] - 1.96 * _se[x21001_0_0]
local ciU _b[x21001_0_0] + 1.96 * _se[x21001_0_0]
post `memhold' ("`myvar'") ("96_40pcs") (`beta') (`ciL') (`ciU')



*****
***** OBSERVATIONAL ASSOCIATION

logistic `myvar' x21001_0_0 age sex

local beta _b[x21001_0_0]
local ciL _b[x21001_0_0] - 1.96 * _se[x21001_0_0]
local ciU _b[x21001_0_0] + 1.96 * _se[x21001_0_0]
post `memhold' ("`myvar'") ("observational") (`beta') (`ciL') (`ciU')
post `memhold' ("`myvar'") ("observational_odds") (exp(`beta')) (exp(`ciL')) (exp(`ciU'))


log close


