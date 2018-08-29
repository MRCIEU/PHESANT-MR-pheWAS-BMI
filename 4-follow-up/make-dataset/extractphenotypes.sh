
outcomeFile="${PROJECT_DATA}/phenotypes/derived/data.21753-phesant_header.csv"

# BMI
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x21001_'


###
### phenotypes identified in MR-pheWAS

# nervous feelings
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x1970_'

# Worrier / anxious feelings
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x1980_'

# Suffering from nerves
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x2010_'

# Tense / highly strung
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x1990_'


###
### others we found by searching

# Seen a psychiatrist for nerves, anxiety, tension or depression
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x2100_'

# Seen doctor (GP) for nerves, anxiety, tension or depression
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x2090_'

# Frequency of tenseness / restlessness in last 2 weeks
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x2070_'


###
### covariates

# age
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x21022_'

# sex
head -n 1 $outcomeFile | sed 's/,/\n/g' | cat -n | egrep 'x31_'



## extract the correct columns from the phenotype file

cut -d, -f1,6620,732,735,744,762,768,738,771,6608,9 $outcomeFile > ${PROJECT_DATA}/phenotypes/derived/nervous-phenos.csv


