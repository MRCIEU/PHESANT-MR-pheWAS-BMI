


# read data

ukbDir=Sys.getenv('UKB_DATA')
dataDir=Sys.getenv('PROJECT_DATA')
phenos = read.table(paste(dataDir,'/phenotypes/derived/nervous-phenos.csv',sep=''), header=1,sep=",")
snps = read.table(paste(dataDir,'/snps/nervousness-snps-withPhenIds.csv',sep=''), header=1,sep=",")
score96 = read.table(paste(dataDir,'/snps/snp-score96-withPhenIds-subset.csv',sep=''), header=1, sep=",")


# add sample indicators

score96$sample500 = 1


# merge

datax = merge(snps, phenos, by='eid', all=TRUE)
datax = merge(datax, score96, by='eid', all=TRUE)

print(dim(datax))

# add PCs 

pcs = read.table(paste(dataDir,'/phenotypes/derived/confounders-PHESANT-followup-pcs40.csv',sep=''), header=1, sep=",")
pcs[,which(colnames(pcs)=="x31_0_0")] = NULL
pcs[,which(colnames(pcs)=="x21022_0_0")] = NULL


datax = merge(datax, pcs, by='eid', all=FALSE)


print(dim(datax))


## make indicator of initial 150K sample and remaining UKB participants

sample150 = read.table(paste(dataDir,'/../snps/snp-score96-withPhenIds-subset.csv', sep=''), header=1, sep=',')

# add prefix to column names
colnames(sample150) <- paste("sample150_", colnames(sample150), sep='')
#sample150[,which(colnames(sample150)=="sample150_app8786")] = NULL
#sample150[,which(colnames(sample150)=="sample150_userId")] = NULL


sample150$sample150 = 1

datax = merge(datax, sample150, by.x='eid', by.y='sample150_eid', all=TRUE)


# sample variable is NA if the participant was in the 150K sample but is now removed from UKB, and so isn't in the full 500K sample
datax$sample = NA

# determine sample status for each example, either:
# case1: in sample150
# case2: in sample500 and not related to anyone in sample150
# case3: in sample500 and related to someone in sample150 so removed from 500K for replication

# for all 150k we can just mark as in this 150k sample
datax$sample[which(datax$sample150 == 1)] = 1

# for all others we need to work out if it is a case 2 or case 3
#ix = which(is.na(datax$sample150))
ix = which(!is.na(datax$sample500))


# we use the relatedness mapping to determine if a participant is a case 3
sample500 = read.table(paste(ukbDir,'/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/id_mapping/app8786/meta.relatedness.dat',sep=''), header=1)

for (r in 1:length(ix)) {

	if (r%%10000 == 0) {
		print(r)
	}

	# get application 8786 ID
	idx = ix[r]
	linkid = datax$app8786.x[idx]

	# find all occurences of this ID in the relateds mapping file
	mapix = which(sample500$ID1 == linkid | sample500$ID2 == linkid)

	has150krelated = FALSE

	# if maps to an id in 150k sample then we don't include in the replcation, otherwise we do include this participant
	if (length(mapix)>0) {
	for (mapr in 1:length(mapix)) {
		mapidx = mapix[mapr]
		row = sample500[mapidx,]
		id1 = row$ID1
		id2 = row$ID2

		# get the id of the related
		if (id1 == linkid) {
			relatedx = id2
		} else {
			relatedx = id1
		}

		# look for related in 150k sample
		ix150 = which(datax$sample150 == 1 & datax$sample150_app8786 == relatedx)

		# related is in 150k sample so don't use this person in the replication sample
		if (length(ix150)>0) {
			has150krelated = TRUE
			break
		}

	}
	}

	if (has150krelated==TRUE) {
		datax$sample[idx] = 3;
	#	print('xx')
	}
	else {
		datax$sample[idx] = 2;
	}

}

# remove people that aren't in 150k or 500k samples
notInAnySample = which(is.na(datax$sample500) & is.na(datax$sample150))
print(paste('Number not in any sample:', length(notInAnySample)))
datax <- datax[-notInAnySample,]


num150 = length(which(datax$sample==1))
num500ButRelated = length(which(datax$sample==3))
num500Replication = length(which(datax$sample==2))

print(paste('Total:', nrow(datax)))
print(paste('Number in 150K sample:', num150))
print(paste('Number in 500K replication:', num500Replication))
print(paste('Number in 500K but related:', num500ButRelated))



# save to file

write.table(datax, paste(dataDir,'/phenotypes/derived/nervous-dataset-replication.csv',sep=''), quote=FALSE, row.names=FALSE, sep=',', na="")


