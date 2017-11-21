

resDir=Sys.getenv('RES_DIR')
resDirMain=paste(resDir,"/results-PHESANT-main-noCIs/",sep="")
resDirSens=paste(resDir,"/results-PHESANT-sensitivity-noCIs/", sep="")

# read results of MR-pheWAS
resMain = read.table(paste(resDirMain, 'results-combined.txt', sep=''), header=1, sep='\t', comment.char='', quote='')
resSens = read.table(paste(resDirSens, 'results-combined.txt', sep=''), header=1, sep='\t', comment.char='', quote='')

resMain = resMain[,c("varName", "pvalue")]
resSens = resSens[,c("varName", "pvalue")]

names(resMain)[2] = "pvalueMain"
names(resSens)[2] = "pvalueSens"

resboth = merge(resMain, resSens, by="varName", all=TRUE)

write.table(resboth, file=paste(resDir, '/results-compare-main-sensitivity.txt', sep=''), sep=',', row.names=FALSE, quote=FALSE, na="")



