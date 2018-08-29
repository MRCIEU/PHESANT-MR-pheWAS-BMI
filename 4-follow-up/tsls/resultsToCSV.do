
* convert stata results file to csv

local resDir : env RES_DIR
use "`resDir'/results-21753/nervous-followup/nervous-results.dta"
outsheet using "`resDir'/results-21753/nervous-followup/nervous-results.csv", replace
