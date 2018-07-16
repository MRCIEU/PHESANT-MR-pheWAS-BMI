

# this code is basically the same as the assocForEgger.r in the twosample-mr directory

dataDir=Sys.getenv('PROJECT_DATA')
resDir=Sys.getenv('RES_DIR')
data = read.table(paste(dataDir,'/phenotypes/derived/nervous-dataset97.csv',sep=''), header=1, sep=',')


varName = "x21001_0_0"

print("################")
print(varName)
print("################")



# BMI SNPs
snps = c("rs977747","rs1460676","rs17203016","rs492400","rs2176040","rs7715256","rs9374842","rs13201877","rs9641123","rs6465468","rs9540493","rs1441264","rs7164727","rs4787491","rs2080454","rs9914578","rs7239883","rs6091540","rs2836754","rs657452","rs11583200","rs3101336","rs12566985","rs12401738","rs11165643","rs13021737","rs10182181","rs11126666","rs6804842","rs2365389","rs10938397","rs2112347","rs205262","rs2207139","rs1167827","rs2245368","rs17405819","rs2033732","rs4740619","rs7899106","rs7138803","rs12429545","rs3736485","rs758747","rs1808579","rs7243357","rs17724992","rs11030104","rs2121279","rs1528435","rs7599312","rs13078960","rs16851483","rs2176598","rs3817334","rs12286929","rs3888190","rs2075650","rs2287019","rs1928295","rs10733682","rs11191560","rs7903146","rs11688816","rs11847697","rs7141420","rs2650492","rs1558902","rs13191362","rs12940622","rs13107325","rs2820292","rs9581854","rs10132280","rs16951275","rs6567160","rs1000940","rs17001654","rs9400239","rs10968576","rs4256980","rs11057405","rs3849570","rs1516725","rs17094222","rs12885454","rs12446632","rs9925964","rs29941","rs17024393","rs1016287","rs543874","rs11727676","rs6477694","rs3810291","rs16907751", "rs2033529")

#### make snp variables in direction of increasing effect on BMI (i.e. to 2- for some of them)
snpsWrongWay = c("rs657452","rs7903146","rs10132280","rs7599312","rs2365389","rs12885454","rs1928295","rs9925964","rs4740619","rs13191362","rs3736485","rs11583200","rs10733682","rs11688816","rs11057405","rs11727676","rs6477694","rs2176598","rs2245368","rs17724992","rs7243357","rs11030104","rs12446632","rs2287019","rs16951275","rs2112347","rs12566985","rs17405819","rs1016287","rs12940622","rs2075650","rs1808579","rs492400","rs7239883","rs16907751","rs9540493","rs6091540","rs2176040","rs2080454","rs977747","rs7715256")

results = data.frame(snp=character(), beta=double(), lower=double(), upper=double(), stringsAsFactors = FALSE)

outcome = data[,varName]
print('standardise BMI');
print(sd(outcome, na.rm=TRUE))
outcome = scale(outcome)
print(sd(outcome, na.rm=TRUE))


varname="snpData"

for (snp in snps) {

	snpData = as.numeric(data[,snp])
	if (snp %in% snpsWrongWay) {
		print(paste("2-", snp, sep=''))
		snpData = 2 - snpData
	}
	else {
		print(snp)
	}

	#####
	## binary dependent variable so assoc should be the log odds estimates
	# associations of snps on outcome
	
	fit <- lm(outcome ~ snpData + ., data=data[,c("x21022_0_0", "x31_0_0")])
        sumx = summary(fit)

	beta = sumx$coefficients[varname,"Estimate"]
	se = sumx$coefficients[varname,"Std. Error"]

	#####
	## add to data frame

	cis = confint(fit, level=0.95)
	lower = cis[varname, "2.5 %"]
	upper = cis[varname, "97.5 %"]
	newRow = data.frame(snp=snp, beta=paste(format(beta, digits=3, trim=FALSE), ' [', format(lower, digits=3, trim=FALSE), ',',format(upper, digits=3, trim=FALSE),']', sep=""))
	results = rbind(results, newRow)

}

warnings()

dataDir=Sys.getenv('PROJECT_DATA')
write.table(results, paste(resDir,'/snp-bmi-assoc97.csv', sep=""), row.names=FALSE, sep=',', quote=FALSE)


