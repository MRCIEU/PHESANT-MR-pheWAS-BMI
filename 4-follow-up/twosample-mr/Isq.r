
# this is code from the paper:
# Bowden et al. Assessing the suitability of summary data for two-sample Mendelian randomization analyses using MR-Egger regression: the role of the I2 statistic, International Journal of Epidemiology, Volume 45, Issue 6, 1 December 2016, Pages 1961–1974


Isq = function(y,s){
	k = length(y)
	w = 1/s^2
	sum.w = sum(w) 
	mu.hat = sum(y*w)/sum.w
	Q = sum(w*(y-mu.hat)^2) 
	Isq = (Q - (k-1))/Q
	Isq = max(0,Isq)
	return(Isq)
}
