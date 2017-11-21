
* convert stata results file to csv

local resDir : env RES_DIR
use "`resDir'/nervous-followup/nervous-results.dta"
outsheet using "`resDir'/nervous-followup/nervous-results.csv", replace
