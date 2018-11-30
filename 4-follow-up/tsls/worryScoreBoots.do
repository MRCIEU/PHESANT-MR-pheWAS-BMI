* apps/stata14

local homeDir : env HOME
local resDir = "`homeDir'/2016-biobank-mr-phewas-bmi/results/sample500k/"
local dataDir = "`homeDir'/2016-biobank-mr-phewas-bmi/data/sample500/"


log using "`resDir'/results-21753/nervous-followup/worryestimates-with-boots.log", text replace


insheet using "`dataDir'/phenotypes/derived/nervous-dataset97.csv", clear


drop rs*

summ x21001_0_0

rename x31_0_0 sex
rename x21022_0_0 age

summ sex
summ age

* standardise score

summ snpscore97
egen snpscore97std = std(snpscore97)
replace snpscore97 = snpscore97std
summ snpscore97

* standardised BMI
* egen x21001_0_0std = std(x21001_0_0)

summ 


replace x1970_0_0 = . if x1970_0_0<0
replace x1980_0_0 = . if x1980_0_0<0
replace x1990_0_0 = . if x1990_0_0<0
replace x2010_0_0 = . if x2010_0_0<0
gen worryscore = .
replace worryscore = x1970_0_0+x1980_0_0+x1990_0_0+x2010_0_0 if x1970_0_0!=. & x1980_0_0!=. & x1990_0_0!=. & x2010_0_0!=.

summ worryscore 
*egen worryscoreSTD = std(worryscore)
*summ worryscore*
*histogram worryscoreSTD 
*graph export "`resDir'/worryScoreHist.pdf", replace

tab worryscore



summ


*****
*****

* estimate with incorrect CIs

regress x21001_0_0 snpscore97 sex age pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10

* predict BMI using model
predict bmipred

summ bmipred worryscore

* estimate assoc of predicted BMI with worry score
ologit worryscore bmipred sex age pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10

drop bmipred



*****
***** bootstrap to get CIs

*bootstrap _b, reps(10) seed(1234): regress csi smokescore sex age pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10

program define myboots, rclass
	 preserve 
	  bsample


	regress x21001_0_0 snpscore97 sex age pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10

	* predict BMI using model
	predict bmipred

	summ bmipred worryscore

	* estimate assoc of predicted BMI with worry score
	ologit worryscore bmipred sex age pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10

	return scalar bworryscore = _b[bmipred]
	restore
end

set seed 1234

file open myfile using "`resDir'/results-21753/nervous-followup/worry-boots.txt", write replace
file write myfile "bootn,bootbeta" _n
forval i = 1/1000 {
	myboots
	di r(bworryscore)
	file write myfile "`i',`r(bworryscore)'" _n
}
file close myfile



log close
exit, clear


