
* convert stata results file to csv

local resDir : env RES_DIR
use "`resDir'/nervous-followup/nervous-results-replication-sample1.dta"
outsheet using "`resDir'/nervous-followup/nervous-results-replication-sample1.csv", replace


use "`resDir'/nervous-followup/nervous-results-replication-sample2.dta"
outsheet using "`resDir'/nervous-followup/nervous-results-replication-sample2.csv", replace

