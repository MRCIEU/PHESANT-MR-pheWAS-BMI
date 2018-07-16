
dir=Sys.getenv('PROJECT_DATA')
ukbdir=Sys.getenv('UKB_DATA')

# info on data used in this qc is here - http://www.ukbiobank.ac.uk/wp-content/uploads/2017/07/ukb_genetic_file_description.txt

shareddir=paste(ukbdir,'/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/',sep='')
qcdatadir=paste(shareddir,'raw_downloaded/qc/',sep='')


outdir=paste(dir,'/qc/',sep='')


#####
##### get data needed for qc

##
# our genetic ids
idfile = paste(shareddir,'id_mapping/app8786/data.fam',sep="")
ids = read.table(idfile, header=0, sep=" ")
names(ids)[1] = "participantid"
ids = ids[,1, drop=FALSE]


##
# main data used for qc

file = paste(qcdatadir, 'ukb_sqc_v2.txt', sep="")
data = read.table(file, header=0, sep=" ")
colNames = c("code","xid","genotyping.array","Batch","Plate.Name","Well","Cluster.CR","dQC","Internal.Pico..ng.uL.","Submitted.Gender","Inferred.Gender","X.intensity","Y.intensity","Submitted.Plate.Name","Submitted.Well","sample.qc.missing.rate","heterozygosity","heterozygosity.pc.corrected","het.missing.outliers","putative.sex.chromosome.aneuploidy","in.kinship.table","excluded.from.kinship.inference","excess.relatives","in.white.British.ancestry.subset","used.in.pca.calculation","PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","PC11","PC12","PC13","PC14","PC15","PC16","PC17","PC18","PC19","PC20","PC21","PC22","PC23","PC24","PC25","PC26","PC27","PC28","PC29","PC30","PC31","PC32","PC33","PC34","PC35","PC36","PC37","PC38","PC39","PC40","in.Phasing.Input.chr1_22","in.Phasing.Input.chrX","in.Phasing.Input.chrXY")
names(data) = colNames

# add ids to main data frame - they are in the same order so we just concat together
data = cbind(ids, data)


#####
##### make exclusion files


##
# sex mismatch

idxexclude = which(data$Submitted.Gender != data$Inferred.Gender)
ids = data$participantid[idxexclude]
write.table(ids,file=paste(outdir, 'sexmismatch.txt',sep=""), row.names=FALSE, col.names=FALSE)


##
# putative sex chromosome aneiplody

idxexclude = which(data$putative.sex.chromosome.aneuploidy == 1)
ids = data$participantid[idxexclude]
write.table(ids,file=paste(outdir, 'aneiplody.txt',sep=""), row.names=FALSE, col.names=FALSE)


##
# het.missing.outliers

idxexclude = which(data$het.missing.outliers == 1)
ids = data$participantid[idxexclude]
write.table(ids,file=paste(outdir, 'hetoutliers.txt',sep=""), row.names=FALSE, col.names=FALSE)


##
# white british

idsexclude = which(data$in.white.British.ancestry.subset == 0)
ids = data$participantid[idsexclude]
write.table(ids,file=paste(outdir, 'whitebritish.txt',sep=""), row.names=FALSE, col.names=FALSE)


# relatedness
# remove 1 individual of each pair that is related up to the third degree in the data set

relFile = paste(shareddir, 'id_mapping/app8786/meta.relatedness.dat', sep="")
rel = read.table(relFile, header=1)
ids = unique(rel$ID1)
write.table(ids,file=paste(outdir, 'relateds.txt',sep=""), row.names=FALSE, col.names=FALSE)





