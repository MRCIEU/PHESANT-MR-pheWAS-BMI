
runMREgger <- function(varName) {

	resDir=Sys.getenv('RES_DIR')
	dataDir=Sys.getenv('PROJECT_DATA')

	outfile = paste(resDir, '/results-21753/nervous-followup/estimates.txt',sep='')

	#install.packages('MendelianRandomization')
	library('MendelianRandomization')

	# load associations of SNPs with BMI and nervousness, resp.
	data = read.table(paste(dataDir,'/phenotypes/derived/followup-assoc-for-egger',varName,'.csv',sep=''), header=1, sep=',')

	locke = read.table('locke-data.txt', header=1, sep='\t')


	# merge by snp name
	alldata=merge(locke, data, by='snp', all=TRUE)


	# I-squared statistics
	isqStat = Isq(alldata$beta,alldata$se)
        print(paste('I-squared statistic: ', isqStat, sep=''))

        isqStat = Isq(alldata$beta/alldata$outcomese,alldata$se/alldata$outcomese)
        print(paste('I-squared statistic, weighted: ', isqStat, sep=''))

	mysimex(varName, alldata, outfile)


	mrInput = mr_input(bx = alldata$beta, bxse = alldata$se, by = alldata$outcomebeta, byse = alldata$outcomese, exposure="BMI", outcome=varName)

	# test association with MR-egger
	egg = mr_egger(mrInput)
	med = mr_median(mrInput)

	write.table(cbind.data.frame(varName, 'mreggerest', egg$Estimate, egg$CILower.Est, egg$CIUpper.Est), file=outfile, append=TRUE, quote=FALSE, sep=',', row.names=FALSE, col.names=FALSE)
	write.table(cbind.data.frame(varName, 'mreggerint', egg$Intercept, egg$CILower.Int, egg$CIUpper.Int), file=outfile, append=TRUE, quote=FALSE, sep=',', row.names=FALSE, col.names=FALSE)
	write.table(cbind.data.frame(varName, 'weightmedest', med$Estimate, med$CILower, med$CIUpper), file=outfile, append=TRUE, quote=FALSE, sep=',', row.names=FALSE, col.names=FALSE)


	# if intercept differs from zero then not all snps are valid instruments


	#BetaXG: vector of instrument-exposure regression coefficients
	#BetaYG: vector of instrument-outcome regression coefficients
	#seBetaXG: vector of instrument-exposure standard errors (SEs)
	#seBetaYG: vector of instrument-outcome SEs
	#phi: tunning parameter (e.g., 1=default bandwidth; 0.5=half of the default bandwidth)
	#n_boot: number of bootstrap iterations
	#alpha: alpha level of the confidence intervals (e.g., alpha=0.05 corresponds to 1-0.05=95% confidence intervals)

	

	mbeOut = MBE(varName, alldata$beta, alldata$outcomebeta, alldata$se, alldata$outcomese)

#	print(mbeOut)
	mbeOut$label = paste("MBE", mbeOut$Method, mbeOut$phi, sep="_")
	mbeOut$field = varName
	mbeOut = mbeOut[, c("field", setdiff(names(mbeOut),"field"))]

	print(mbeOut)

	mbeOut = mbeOut[,c("field", "label", "Estimate", "CI_low", "CI_upp")]
	write.table(mbeOut, file=outfile, append=TRUE, quote=FALSE, sep=',', row.names=FALSE, col.names=FALSE)

}



