
	catId=100059

	resDir=paste(Sys.getenv('RES_DIR'), '/results-PHESANT-main-noCIs/', sep='')
	catId=100059

	res = read.table(paste(resDir, 'results-combined-cat',catId,'.txt',sep=""), header=0, sep='\t', comment.char="", quote="")

	if (nrow(res)<10) {
		print("Less than 10 results")
		print(res)
		return(NULL)
	}

	names(res) = c('pvalue', 'fid')

	# sort results by p value
	pSort = sort(res[,"pvalue"])
	numRes = length(pSort)
	fids = res$fid[order(res$pvalue)]

	# generate value for plotting
	rank = rank(pSort, ties.method="first")
	rankProportion = rank/numRes
	rankProportionLog10 = -log10(rankProportion)
	pLog10 = -log10(pSort)

	## do bonferroni correction and output this.
	print(paste('Number of tests:', numRes))
	bonf= 0.05/numRes
	print(paste('Bonferroni threshold:', bonf))
	threshold = -log10(bonf)
	belowBonf = length(which(pSort<bonf))
	print(paste('Number below Bonferroni threshold:', belowBonf));

	# check pvalues are valid (not zero)
        idxZero = which(pSort==0)
        if (length(idxZero)>0) {
                print(paste("There are ", length(idxZero)," results with pvalues too small to be stored exactly, colored red on QQ plot.", sep=""))
        }

	# set indicator for pvalue ~zero (we don't have a precise p value for these results), these are coloured red on QQ plot
	zeroVal  = rep(0, length(rankProportionLog10))
	zeroVal[idxZero] = 1
	zeroVal = as.factor(zeroVal)
	pLog10[idxZero] = -log10(5e-324)

	## plot qqplot
	pdf(paste(resDir,"qqplot-cat",catId,".pdf",sep=""))

	# qq
	par(pch='.')

	# axis range
	xmin=0
	xmax=max(rankProportionLog10)+0.9
	ymin=0
	ymax=max(threshold, max(pLog10))

	plot(rankProportionLog10, pLog10,col=c("#990099", "red")[zeroVal], xlab='expected -log10(p)', ylab='actual -log10(p)',cex=0.8, pch=c(16, 8)[zeroVal], xlim=c(xmin, xmax), ylim=c(ymin, ymax))


	###
	### bonferroni threshold

        # horizontal threshold line, dashed green
        segments(0, threshold, xmax+0.5, threshold, col='#008000',lty=2)

	###
	### text for points

	tx = fids
	mypos = rep(c(4),length(rankProportionLog10))
	tx = gsub('#([A-Z0-9]+):', ' value \\1:', tx)
	tx = gsub('-[0-9]+:', ':', tx)
	tx = gsub('"', '', tx)	
	tx = gsub('\\(recoded\\)', '', tx)


	print(tx[1:20])


	# improve positioning of labels

	myvalues=c('Pub or social club','financial difficulties', 'Serious illness, injury or assault to yourself')
	count=1
	for (i in c(5,9,11)) {
		tx[i] = paste(tx[i], myvalues[count], sep=': ')
		count=count+1
	}
	mypos[c(1)] = 2
	pLog10[11] = pLog10[11]-0.2
	pLog10[12] = pLog10[12]-0.2


	print(tx[1:20])


#	tx = substr(tx, 1, 60)
#        ix = which(nchar(as.character(tx))>57)
#        tx[ix] = paste(tx[ix], '...')
        tx[which(pSort>=bonf)] = ""



	text(rankProportionLog10, pLog10, labels=tx, cex= 0.5, pos=mypos)


	###
	### ascending diagonal, dotted blue

#	minVal = min(max(rankProportionLog10), xmax+0.5)
	segments(0, 0, 2.5, 2.5, col='#0066cc',lty=3)	

	junk<- dev.off()

	print("Finished QQ plot")

