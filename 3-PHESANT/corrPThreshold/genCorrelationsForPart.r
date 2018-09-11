


dataDir=paste(Sys.getenv('HOME'), '/2016-biobank-mr-phewas-bmi/data/sample500/', sep='')
#dataDir=Sys.getenv('PROJECT_DATA')
saveDir=paste(dataDir,'/phenotypes/derived/phesant-save/',sep='')



genCorrelations <- function(jobidx) {

	# load data for this job
	contFile=paste(saveDir, 'data-cont-',jobidx,'-200.txt',sep='')
	catordFile=paste(saveDir, 'data-catord-',jobidx,'-200.txt',sep='')
	binFile=paste(saveDir, 'data-binary-',jobidx,'-200.txt',sep='')
	contPhenos=read.table(contFile, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
	catordPhenos=read.table(catordFile, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
	binPhenos=read.table(binFile, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)

	for (i in 1:200) {

		contFileI=paste(saveDir, 'data-cont-', i,'-200.txt',sep='')
		catordFileI=paste(saveDir, 'data-catord-', i,'-200.txt',sep='')
		binFileI=paste(saveDir, 'data-binary-', i,'-200.txt',sep='')
		contPhenosI=read.table(contFileI, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
		catordPhenosI=read.table(catordFileI, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)
		binPhenosI=read.table(binFileI, sep=',', header=1, comment.char='', quote='', colClasses='numeric', stringsAsFactors=FALSE)


		## test correlations

		testCorrelationsBetween(contPhenos, contPhenosI, jobidx, i, 'cont', 'cont')
		testCorrelationsBetween(contPhenos, catordPhenosI, jobidx, i, 'cont', 'catord')
		testCorrelationsBetween(contPhenos, binPhenosI, jobidx, i, 'cont', 'bin')

		testCorrelationsBetween(catordPhenos, contPhenosI, jobidx, i, 'catord', 'cont')
	        testCorrelationsBetween(catordPhenos, catordPhenosI, jobidx, i, 'catord', 'catord')
	        testCorrelationsBetween(catordPhenos, binPhenosI, jobidx, i, 'catord', 'bin')

		testCorrelationsBetween(binPhenos, contPhenosI, jobidx, i, 'bin', 'cont')
	        testCorrelationsBetween(binPhenos, catordPhenosI, jobidx, i, 'bin', 'catord')
	        testCorrelationsBetween(binPhenos, binPhenosI, jobidx, i, 'bin', 'bin')

	}
}

# correlating all phenos in df1 with all phenos in df2
testCorrelationsBetween <- function(df1, df2, job1, job2, type1, type2) {

	# check if this correlations hasn't already been generated
	myfilename=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'.txt', sep='')
	if (file.exists(myfilename)) {
                return(NULL)
        }

	# we assume the participant ids are in the same order so we assert this to check
	stopifnot(df1$userID == df2$userID)

	# remove user id column	and check there	is at least 1 pheno in each dataframe
	x1 = df1[,-which(colnames(df1)=="userID"), drop=FALSE]
	x2 = df2[,-which(colnames(df2)=="userID"), drop=FALSE]

	if (ncol(x1) == 0 || ncol(x2) == 0) {
		return(NULL)
	}

	mycors = cor(x1, x2, method='spearman', use='pairwise.complete.obs')

	##
        ## save	as matrix

	write.table(format(mycors, digits=6, scientific=F), myfilename, sep=',', col.names=FALSE, row.names=FALSE, quote=FALSE)

	myfilenameCols=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'COLS.txt', sep='')
        myfilenameRows=paste(saveDir, 'correlations/cor-', job1, '-', job2, '-', type1,'-', type2,'ROWS.txt', sep='')
	write.table(colnames(mycors), myfilenameCols, sep=',', col.names=FALSE, row.names=FALSE, quote=FALSE)
	write.table(rownames(mycors), myfilenameRows, sep=',', col.names=FALSE, row.names=FALSE, quote=FALSE)
}




args <- commandArgs(trailingOnly = TRUE)
genCorrelations(as.numeric(args[1]))


