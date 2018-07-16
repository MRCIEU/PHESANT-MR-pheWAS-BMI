* apps/stata14

local myvar `1'
local memhold `2'

local resDir : env RES_DIR

log using "`resDir'/nervous-followup/nervous-results`myvar'.log", text replace


replace `myvar' = . if `myvar' ==-3 
replace `myvar' = . if `myvar' ==-1
tab `myvar'

replace `myvar' = 2 if `myvar' ==3
replace `myvar' = 2 if `myvar' ==4

replace `myvar' = 0 if `myvar' ==1
replace `myvar' = 1 if `myvar' ==2



* 96 snp score 
ivprobit `myvar' age sex pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10 (x21001_0_0 = snpscore97), first

local beta _b[x21001_0_0]
local ciL _b[x21001_0_0] - 1.96 * _se[x21001_0_0]
local ciU _b[x21001_0_0] + 1.96 * _se[x21001_0_0]
post `memhold' ("`myvar'") ("96_main") (`beta') (`ciL') (`ciU')
post `memhold' ("`myvar'") ("96_main_odds") (exp(1.6*(`beta'))) (exp(1.6*(`ciL'))) (exp(1.6*(`ciU')))


* 95 snp score (excluding FTO)
ivprobit `myvar' age sex pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10 (x21001_0_0 = snpscore96), first

local beta _b[x21001_0_0]
local ciL _b[x21001_0_0] - 1.96 * _se[x21001_0_0]
local ciU _b[x21001_0_0] + 1.96 * _se[x21001_0_0]
post `memhold' ("`myvar'") ("95_main") (`beta') (`ciL') (`ciU')


* FTO
ivprobit `myvar' age sex pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10 (x21001_0_0 = rs1558902), first

local beta _b[x21001_0_0]
local ciL _b[x21001_0_0] - 1.96 * _se[x21001_0_0]
local ciU _b[x21001_0_0] + 1.96 * _se[x21001_0_0]
post `memhold' ("`myvar'") ("fto_main") (`beta') (`ciL') (`ciU')


log close
