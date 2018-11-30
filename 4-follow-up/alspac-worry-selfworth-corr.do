
local dataDir : env PROJECT_DATA

* child clinic TF3 data
use "`dataDir'/alspac/tf3_4a.dta"

* child clinic TF4 data
merge 1:1 aln qlet using "`dataDir'/alspac/tf4_4a.dta"
drop if _merge!=3

* worry question
summ fh6500
tab fh6500
tab fh6500, nolabel
drop if fh6500 < 0

* self-worth score
summ FJCQ1003
hist FJCQ1003
tab FJCQ1003
tab  FJCQ1003, nolabel
drop if  FJCQ1003<0
summ  FJCQ1003



* correlation between self-worth and worry

pwcorr fh6500 FJCQ1003, sig


sort fh6500
by fh6500: summ FJCQ1003 


