

library(reshape2)
#library(parallel)

dataDir=paste(Sys.getenv('HOME'), '/2016-biobank-mr-phewas-bmi/data/sample500/', sep='')
saveDir=paste(dataDir,'/phenotypes/derived/phesant-save/',sep='')



genCorrelationstmp5 <- function(jobidx, i, rowx) {

	# load data for this job
	contFile=paste(saveDir, 'data-cont-',jobidx,'-200.txt',sep='')
	catordFile=paste(saveDir, 'data-catord-',jobidx,'-200.txt',sep='')
	binFile=paste(saveDir, 'data-binary-',jobidx,'-200.txt',sep='')
	contPhenos=read.table(contFile, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
	catordPhenos=read.table(catordFile, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
	binPhenos=read.table(binFile, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)


#	data = fread(contFile, select=, sep=',', header=TRUE, data.table=FALSE, na.strings=c("", "NA"))



#	for (i in (jobidx+1):200) {
#	for (i in 150:200) {
	
		contFileI=paste(saveDir, 'data-cont-', i,'-200.txt',sep='')
		catordFileI=paste(saveDir, 'data-catord-', i,'-200.txt',sep='')
		binFileI=paste(saveDir, 'data-binary-', i,'-200.txt',sep='')
		contPhenosI=read.table(contFileI, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
		catordPhenosI=read.table(catordFileI, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
		binPhenosI=read.table(binFileI, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)


		## test correlations

		testCorrelationsBetween5(contPhenos, contPhenosI, jobidx, i, 'cont', 'cont', rowx)
		testCorrelationsBetween5(contPhenos, catordPhenosI, jobidx, i, 'cont', 'catord', rowx)
		testCorrelationsBetween5(contPhenos, binPhenosI, jobidx, i, 'cont', 'bin', rowx)

		testCorrelationsBetween5(catordPhenos, contPhenosI, jobidx, i, 'catord', 'cont', rowx)
	        testCorrelationsBetween5(catordPhenos, catordPhenosI, jobidx, i, 'catord', 'catord', rowx)
	        testCorrelationsBetween5(catordPhenos, binPhenosI, jobidx, i, 'catord', 'bin', rowx)

		testCorrelationsBetween5(binPhenos, contPhenosI, jobidx, i, 'bin', 'cont', rowx)
	        testCorrelationsBetween5(binPhenos, catordPhenosI, jobidx, i, 'bin', 'catord', rowx)
	        testCorrelationsBetween5(binPhenos, binPhenosI, jobidx, i, 'bin', 'bin', rowx)

#	}
}


# correlating all phenos in df1 with all phenos in df2
testCorrelationsBetween5 <- function(df1, df2, job1, job2, type1, type2, rowx) {

	# check if this correlations hasn't already been generated
	myfilename=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'.txt', sep='')
	if (file.exists(myfilename)) {
               return(NULL)
       	}

	# we assume the participant ids are in the same order so we assert this to check
	stopifnot(df1$userID == df2$userID)

	# remove user id column	and check there	is at least 1 pheno in each dataframe
	xx1 = df1[,-which(colnames(df1)=="userID"), drop=FALSE]
	x2 = df2[,-which(colnames(df2)=="userID"), drop=FALSE]

	if (ncol(xx1) == 0 || ncol(x2) == 0) {
		return(NULL)
	}

	
	####
	#### correlation for specfific row of job1

	# check if this correlations hasn't already been generated
	myfilename=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'-rowx',rowx,'.txt', sep='')
        if (file.exists(myfilename)) {
                return(NULL)
        }

	# row in generated correlation matrix is for column in x1
	colstart=(rowx*10)-9
	colend=colstart+9

	numcols=ncol(xx1)
	# get 100 rows of first matrix
	if (colstart>numcols) {
		return(NULL)
	}
	else if (colend>numcols) {
		x1 = xx1[,colstart:numcols]
	}
	else {
		x1 = xx1[,colstart:colend]
	}

	mycors = cor(x1, x2, method='spearman', use='pairwise.complete.obs')


	##
        ## save	as matrix

	write.table(format(mycors, digits=6, scientific=F), myfilename, sep=',', col.names=FALSE, row.names=FALSE, quote=FALSE)

	myfilenameCols=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'COLS-row',rowx,'.txt', sep='')
        myfilenameRows=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'ROWS-row',rowx,'.txt', sep='')
	write.table(colnames(mycors), myfilenameCols, sep=',', col.names=FALSE, row.names=FALSE, quote=FALSE)
	write.table(rownames(mycors), myfilenameRows, sep=',', col.names=FALSE, row.names=FALSE, quote=FALSE)


}




args <- commandArgs(trailingOnly = TRUE)
genCorrelationstmp5(as.numeric(args[1]), as.numeric(args[2]), as.numeric(args[3]))

print("DONE X")
