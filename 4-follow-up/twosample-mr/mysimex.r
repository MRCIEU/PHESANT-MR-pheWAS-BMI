# this is code from the paper:
# Bowden et al. Assessing the suitability of summary data for two-sample Mendelian randomization analyses using MR-Egger regression: the role of the I2 statistic, International Journal of Epidemiology, Volume 45, Issue 6, 1 December 2016, Pages 1961–1974
#

# load the simex package

#mysimex = function(varName, BetaXG, seBetaXG, BetaYG, seBetaYG) {

mysimex = function(varName, alldata, outfile) {

	BetaXG <<- alldata$beta
	seBetaXG <<- alldata$se
	BetaYG <<- alldata$outcomebeta
	seBetaYG <<- alldata$outcomese

	library(simex)

	# MR-Egger regression (weighted)
	Fit2 = lm(BetaYG~BetaXG,weights=1/seBetaYG^2,x=TRUE,y=TRUE)

	print(Fit2)

	# Simulation extrapolation
	mod.sim <- simex(Fit2,B=1000, measurement.error=seBetaXG, SIMEXvariable="BetaXG", fitting.method ="quad", asymptotic="FALSE")

	print(mod.sim)
	
	print(summary(mod.sim))
	sum = summary(mod.sim)

	coefs = sum$coefficients$jackknife
#	print(coefs)

	sx = coefs[2,"Std. Error"]
	bx = coefs[2,"Estimate"] 
	cilower = bx - 1.96*sx
	ciupper = bx + 1.96*sx

	print(paste('SIMEX estimate: ', bx, ' [', cilower, ', ', ciupper, ']', sep=''))

	write.table(cbind.data.frame(varName, 'mreggerestSIMEX', bx, cilower, ciupper), file=outfile, append=TRUE, quote=FALSE, sep=',', row.names=FALSE, col.names=FALSE)
        

	print('plotting ...')
	
	# plot results
	resDir=Sys.getenv('RES_DIR')
	pdf(paste(resDir,'/nervous-followup/mreggersimex',varName,'.pdf',sep=''))

	l = mod.sim$SIMEX.estimates[,1]+1
	b = mod.sim$SIMEX.estimates[,3] 
	plot(l[-1],b[-1],ylab="",xlab="",pch=19,ylim=range(b),xlim=range(l)) 
	mtext(side=2,"Causal estimate",line=2.5,cex=1.5)
	mtext(side=1,expression(1+lambda),line=2.5,cex=1.5) 
	points(c(1,1),rep(Fit2$coef[2],2),cex=2,col="blue",pch=19) 
	points(c(0,0),rep((mod.sim$coef[2]),2),cex=2,col="blue",pch=3) 
	legend("bottomright",c("Naive MR-Egger","MR-Egger (SIMEX)"), pch = c(19,3),cex=1.5,bty="n",col=c("blue","blue")) 
	lsq = l^2; f = lm(b~l+lsq)
	lines(l,f$fitted)

	dev.off()


}
