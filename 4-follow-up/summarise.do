
* apps/stata14

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

**
* load our score data

insheet using "`dataDir'/phenotypes/derived/nervous-dataset97.csv", clear
keep eid

**
* merge in with our basic characteristics data, keeping the right sample (N=334,968)

merge 1:1 eid using "`dataDir'/phenotypes/derived/data.21753-phesant_header-summarycharacterisics.dta"

count

tab _merge
keep if _merge == 3
drop _merge

count


**
* clean phenos

keep x*


replace x1970_0_0 = . if x1970_0_0<0
replace x1980_0_0 = . if x1980_0_0<0
replace x1990_0_0 = . if x1990_0_0<0
replace x2010_0_0 = . if x2010_0_0<0
replace x845_0_0 = . if x845_0_0<0
replace x4598_0_0 = . if x4598_0_0 < 0
replace x20116_0_0 = . if x20116_0_0 < 0


tab x20116_0_0
replace x20116_0_0 = 1 if x20116_0_0 == 2

**
* check data

summ

**
* summarise


* bmi
sort x1970_0_0
by x1970_0_0: summ x21001_0_0
sort x1980_0_0
by x1980_0_0: summ x21001_0_0
sort x1990_0_0
by x1990_0_0: summ x21001_0_0
sort x2010_0_0
by x2010_0_0: summ x21001_0_0


logistic x1970_0_0 x21001_0_0
logistic x1980_0_0 x21001_0_0
logistic x1990_0_0 x21001_0_0
logistic x2010_0_0 x21001_0_0


* smoking
tab x20116_0_0 x1970_0_0, col
tab x20116_0_0 x1980_0_0, col
tab x20116_0_0 x1990_0_0, col
tab x20116_0_0 x2010_0_0, col

logistic x1970_0_0 x20116_0_0
logistic x1980_0_0 x20116_0_0
logistic x1990_0_0 x20116_0_0
logistic x2010_0_0 x20116_0_0


* education
sort x1970_0_0
by x1970_0_0: summ x845_0_0
sort x1980_0_0
by x1980_0_0: summ x845_0_0
sort x1990_0_0
by x1990_0_0: summ x845_0_0
sort x2010_0_0
by x2010_0_0: summ x845_0_0

logistic x1970_0_0 x845_0_0
logistic x1980_0_0 x845_0_0
logistic x1990_0_0 x845_0_0
logistic x2010_0_0 x845_0_0


* age
sort x1970_0_0
by x1970_0_0: summ x21022_0_0
sort x1980_0_0
by x1980_0_0: summ x21022_0_0
sort x1990_0_0
by x1990_0_0: summ x21022_0_0
sort x2010_0_0
by x2010_0_0: summ x21022_0_0

logistic x1970_0_0 x21022_0_0
logistic x1980_0_0 x21022_0_0
logistic x1990_0_0 x21022_0_0
logistic x2010_0_0 x21022_0_0




* townsend
sort x1970_0_0
by x1970_0_0: summ x189_0_0
sort x1980_0_0
by x1980_0_0: summ x189_0_0
sort x1990_0_0
by x1990_0_0: summ x189_0_0
sort x2010_0_0
by x2010_0_0: summ x189_0_0

logistic x1970_0_0 x189_0_0
logistic x1980_0_0 x189_0_0
logistic x1990_0_0 x189_0_0
logistic x2010_0_0 x189_0_0



* depressed whole week 4598
tab x4598_0_0 x1970_0_0, col
tab x4598_0_0 x1980_0_0, col
tab x4598_0_0 x1990_0_0, col
tab x4598_0_0 x2010_0_0, col

logistic x1970_0_0 x4598_0_0
logistic x1980_0_0 x4598_0_0
logistic x1990_0_0 x4598_0_0
logistic x2010_0_0 x4598_0_0



* sex
tab x31_0_0 x1970_0_0, col
tab x31_0_0 x1980_0_0, col
tab x31_0_0 x1990_0_0, col
tab x31_0_0 x2010_0_0, col


logistic x1970_0_0 x31_0_0
logistic x1980_0_0 x31_0_0   
logistic x1990_0_0 x31_0_0   
logistic x2010_0_0 x31_0_0   




