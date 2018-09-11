
# qsub -l walltime=00:06:00:00,nodes=1:ppn=1 -I -qhimem

dataDir=Sys.getenv('PROJECT_DATA')

phenofile=paste(dataDir, '/phenotypes/derived/data.21753-phesant_header.csv', sep='')
phenos=read.table(phenofile, header=1, sep=',')

expFile=paste(dataDir,'/snps/snp-score97-withPhenIds-subset.csv',sep='')
dataExp = read.table(expFile, header=1, sep=',')
dataExp = dataExp[,c("eid"), drop=FALSE]

alldata=merge(dataExp, phenos, by='eid', all=FALSE)




write.table(alldata, paste(dataDir, '/phenotypes/derived/data.21753-phesant_header-SUBSET.csv', sep=''), sep=',', row.names=FALSE, quote=TRUE, na="")

