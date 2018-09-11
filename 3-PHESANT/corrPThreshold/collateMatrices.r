


dataDir=paste(Sys.getenv('HOME'), '/2016-biobank-mr-phewas-bmi/data/sample500/', sep='')
corDir=paste(dataDir,'/phenotypes/derived/phesant-save/correlations/',sep='')

types=c('cont', 'bin','catord')

matrixall = NULL

# set of rows for each i
for (i in 153:153) {

	print(i)
	# row for each type for each i
	for (it in types) {
#		print(it)

		# column group for row i and each j
		for (j in 1:200) {
			
			for (jt in types) {

				matrixfilename=paste(corDir, 'cor-',i,'-',j,'-',it,'-',jt,'.txt', sep='')
				matrixfilenamereverse=paste(corDir, 'cor-',j,'-',i,'-',jt,'-',it,'.txt', sep='')
				matrixfilenameBYROW=paste(corDir, 'cor-',i,'-',j,'-',it,'-',jt,'-rowx1.txt', sep='')
				matrixfilenameBYROWreverse=paste(corDir, 'cor-',j,'-',i,'-',jt,'-',it,'-rowx1.txt', sep='')

				cormat=NULL

				if (file.exists(matrixfilename)) {
					print(matrixfilename)
					cormat = read.table(matrixfilename, header=0, sep=',')
#					print(dim(cormat))
				}
				else if (file.exists(matrixfilenamereverse)) {
					print(matrixfilenamereverse)
                                       	cormat = read.table(matrixfilenamereverse, header=0, sep=',')
					cormat = t(cormat)
                	        }
				else if (file.exists(matrixfilenameBYROW)) {
					print(matrixfilenameBYROW)
					rowx=1
					while (file.exists(matrixfilenameBYROW)) {
						cormatrow = read.table(matrixfilenameBYROW, header=0, sep=',')
						print(rowx)
						print(nrow(cormatrow))
						if (is.null(cormat)) {
        	                                        cormat = cormatrow
                                        	}
                                        	else {
                                        	      	cormat = rbind(cormat, cormatrow)
                                        	}
						rowx=rowx+1
						matrixfilenameBYROW=paste(corDir, 'cor-',i,'-',j,'-',it,'-',jt,'-rowx',rowx,'.txt', sep='')
					}	

				}
				else if (file.exists(matrixfilenameBYROWreverse)) {
                                        print(matrixfilenameBYROWreverse)
					rowx=1
                                        while (file.exists(matrixfilenameBYROWreverse)) {
                                                cormatrow = read.table(matrixfilenameBYROWreverse, header=0, sep=',')
						print(rowx)
						print(nrow(cormatrow))
						if (is.null(cormat)) {
                                                        cormat = cormatrow
                                                }
                                                else {
                                                      	cormat = rbind(cormat, cormatrow)
                                                }
                                                rowx=rowx+1
                                                matrixfilenameBYROWreverse=paste(corDir, 'cor-',j,'-',i,'-',jt,'-',it,'-rowx',rowx,'.txt', sep='')
                                        }

					cormat = t(cormat)
				}


				# check dimensions against expected
				
				if (!is.null(cormat)) {
					if (is.null(matrixall)) {
	                                        matrixall = cormat
	                                }
	                                else {
	                                        matrixall = cbind(matrixall, cormat)
	                                }
				}

			}

		}

		print(dim(matrixall))
		# save the set of rows corresponding to job i (then we just add these together after)
		write.table(matrixall, paste(corDir, 'cormat-',i,'-', it,'.txt', sep=''), row.names=FALSE, col.names=FALSE, sep=',')
		matrixall = NULL
	}

}
