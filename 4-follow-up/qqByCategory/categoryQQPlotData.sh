


# Psychosocial factors
cat=100059
awk -F'\t' '($10!="YES" && ($11=="'$cat'" || $13=="'$cat'" || $15=="'$cat'")) {print $7 "\t" $1 ": " $9 }'  ${RES_DIR}/results-PHESANT-main/results-combined.txt > ${RES_DIR}/results-PHESANT-main/results-combined-cat${cat}.txt

