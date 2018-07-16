
module add languages/python-2.7.6
module add apps/matlab-r2015a


######
###### PHENO data preparation

####
# combine gen files
snpDir="${PROJECT_DATA}/snps/"
cat ${snpDir}snp-out*.gen > ${snpDir}snps-97.gen


####
# convert from gen to snp dosages
cat ${snpDir}snps-97.gen | python gen_to_expected.py > ${snpDir}snps-all-expected.txt


####
# check the number of fields
awk '{print NF}' ${snpDir}snps-all-expected.txt

####
# Remove the first 6 columns from SNP file, that we don't need
cut -d' ' -f 7- ${snpDir}snps-all-expected.txt > ${snpDir}snps-all-expected2.txt

####
# Transpose the data so the SNPs are columns and the participants are rows
matlab -r doTranspose


######
###### USER ID preparation

####
# get user ID column from sample file (all sample files should be the same)

ddir="${UKB_DATA}/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/"
sampleFile="${ddir}sample-stats/data.chr01.sample"

awk '(NR>2) {print $1}' $sampleFile > ${snpDir}userIds.txt


######
###### Add user ids to pheno data


# Get the SNP names and make this the header row of the snp data file

cut -d' ' -f 3 ${snpDir}snps-all-expected.txt >${snpDir}snp-names.txt
tr '\n' ',' < ${snpDir}snp-names.txt > ${snpDir}snp-data97.txt

# remove last comma and add new line to file
sed -i 's/,$//g' ${snpDir}snp-data97.txt
sed -i 's/$/\n/g' ${snpDir}snp-data97.txt
sed -i 's/^/userId,/g' ${snpDir}snp-data97.txt


# Join the SNP data with the user ID column and append this to the snp data file:
cat ${snpDir}snps-all-expected2-transposed.txt | paste -d',' ${snpDir}userIds.txt -  >> ${snpDir}snp-data97.txt


####
#### basic checking

# number of columns should be number of SNPs + 1 (user id column)
awk -F, '{print NF}' ${snpDir}snp-data97.txt | head

# number of rows should be number of people + 1 (header row)
wc -l ${snpDir}snp-data97.txt
