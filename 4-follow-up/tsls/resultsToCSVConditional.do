
* convert stata results file to csv

local resDir : env RES_DIR
use "`resDir'/nervous-followup/nervous-results-conditional.dta"
outsheet using "`resDir'/nervous-followup/nervous-results-conditional.csv", replace
