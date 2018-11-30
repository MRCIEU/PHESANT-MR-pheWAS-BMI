
local resDir : env RES_DIR
local dataDir : env PROJECT_DATA


* calculating the heterogeneity of the FTO vs 96 SNP score estimates


insheet using "`resDir'/results-21753/nervous-followup/nervous-results.csv", clear



**
** Field 1970

list if field=="x1970_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x1970_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x1970_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds"), random


**
** Field 1980

list if field=="x1980_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x1980_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x1980_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds"), random


**
** Field 1990

list if field=="x1990_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x1990_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x1990_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds"), random


**
** Field 2010

list if field=="x2010_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x2010_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds")

metan estimate lower upper if field=="x2010_0_0" & (test=="fto_stdbmi_logodds" | test=="96_stdbmi_logodds"), random

