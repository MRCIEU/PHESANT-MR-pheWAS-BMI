
source("runMREgger.r")
source("modeBasedEstimate.r")
source("Isq.r")
source("mysimex.r")

resDir=Sys.getenv('RES_DIR')

outfile = paste(resDir,'/nervous-followup/estimates.txt', sep='')
write.table(cbind.data.frame('field', 'test', 'estimate', 'lower', 'upper'), file=outfile, append=FALSE, row.names=FALSE, col.names=FALSE, sep=",")


set.seed(12345)


varName="x1970_0_0"
print(varName)
runMREgger(varName)

varName="x1980_0_0"
print(varName)
runMREgger(varName)

varName="x1990_0_0"
print(varName)
runMREgger(varName)

varName="x2010_0_0"
print(varName)
runMREgger(varName)

