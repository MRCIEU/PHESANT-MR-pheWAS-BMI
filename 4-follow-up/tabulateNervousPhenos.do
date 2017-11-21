
local resDir : env RES_DIR
local dataDir : env PROJECT_DATA


log using "`resDir'/nervous-followup/nervous-tabulations.log", text replace

insheet using "`dataDir'/phenotypes/derived/nervous-dataset.csv", clear


foreach myvar of varlist x1970_0_0 x1980_0_0 x1990_0_0 x2010_0_0 x2100_0_0 x2090_0_0 x2070_0_0 {
	replace `myvar' = . if `myvar' ==-10
	replace `myvar' = . if `myvar' ==-3 
	replace `myvar' = . if `myvar' ==-1
	tab `myvar'
}

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

drop if sex == .
drop if age == . 
drop if snpscore96 == .
drop if x21001_0_0 == .


**** correlations between nervous traits

*pwcorr x1970_0_0 x1980_0_0
*pwcorr x1970_0_0 x1980_0_0

**** contingency tables to compare nervous / anxiety variables with each other

tab x1970_0_0 x1980_0_0, chi2 cell
di `r(p)'
tab x1970_0_0 x1990_0_0, chi2 cell
di `r(p)'
tab x1970_0_0 x2010_0_0, chi2 cell
di `r(p)'
*tab x1970_0_0 x2100_0_0, chi2 cell
*di `r(p)'
*tab x1970_0_0 x2090_0_0, chi2 cell
*di `r(p)'
*tab x1970_0_0 x2070_0_0, chi2 cell
*di `r(p)'


tab x1980_0_0 x1990_0_0, chi2 cell
di `r(p)'
tab x1980_0_0 x2010_0_0, chi2 cell
di `r(p)'

tab x1990_0_0 x2010_0_0, chi2 cell
di `r(p)'


log close


