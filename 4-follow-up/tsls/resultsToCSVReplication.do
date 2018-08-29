
* convert stata results file to csv

local resDir : env RES_DIR
use "`resDir'/results-21753/nervous-followup/nervous-results-replication-sample1.dta"
outsheet using "`resDir'/results-21753/nervous-followup/nervous-results-replication-sample1.csv", replace


use "`resDir'/results-21753/nervous-followup/nervous-results-replication-sample2.dta"
outsheet using "`resDir'/results-21753/nervous-followup/nervous-results-replication-sample2.csv", replace

