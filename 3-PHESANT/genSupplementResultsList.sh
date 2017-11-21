

# results directory for sensitivity analysis
resDir="${RES_DIR}/results-PHESANT-main-noCIs/"

cat ${resDir}results-combined.txt | grep -v 'varName' | awk -F'\t' '($10=="") {gsub("-"," baseline:",$1); gsub("#"," category:",$1); print $1 "," $9 "," $7 "," $2 "," $8 "," $11 "," $12 "," $13 "," $14 "," $15 "," $16}' > ${resDir}results-listing-for-supplement.csv
