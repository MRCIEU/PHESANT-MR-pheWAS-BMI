

# results directory for sensitivity analysis
resDir="${RES_DIR}/results-21753/results-PHESANT-main/"

cat ${resDir}results-combined.txt | grep -v 'varName' | awk -F'\t' '($10=="") {gsub("-"," baseline:",$1); gsub("#"," category:",$1); print $1 "\t" $9 "\t" $7 "\t" $2 "\t" $8 "\t" $11 "\t" $12 "\t" $13 "\t" $14 "\t" $15 "\t" $16}' | sed 's/,//g' > ${resDir}results-listing-for-supplement.csv
