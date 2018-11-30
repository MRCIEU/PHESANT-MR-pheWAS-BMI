
* apps/stata14

local dataDir : env PROJECT_DATA


insheet using "`dataDir'/phenotypes/derived/data.21753-phesant_header-summarycharacterisics.csv", clear
count


save "`dataDir'/phenotypes/derived/data.21753-phesant_header-summarycharacterisics.dta", replace





