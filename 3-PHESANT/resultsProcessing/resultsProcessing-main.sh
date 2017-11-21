

module add languages/R-3.3.1-ATLAS

# PHESANT code subdirectory
resultsProcessingDir="${PHESANT}/resultsProcessing/"

# directory with PHESANT results
resDir="${RES_DIR}/results-PHESANT-main-noCIs/"

cd $resultsProcessingDir
Rscript mainCombineResults.r --resDir=${resDir} --numParts=200 --variablelistfile="../variable-info/outcome-info.tsv"

