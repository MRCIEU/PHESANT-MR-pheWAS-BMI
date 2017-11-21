

require(lmtest)

resDir=Sys.getenv('RES_DIR')
dataDir=Sys.getenv('PROJECT_DATA')

acFile=paste(dataDir,'/phenotypes/derived/confounders-PHESANT-sensitivity-merged.csv',sep='')

expFile=paste(dataDir,'/snps/snp-score96-withPhenIds-subset.csv',sep='')
confFile=paste(dataDir,'/phenotypes/derived/confounders-PHESANT-followup-pcs40.csv',sep='')

 sink(paste(resDir,'/pop-strat-assesscentre-out.txt',sep=''), append=FALSE, split=FALSE)

####
#### load data

acs = c('assCentre11001', 'assCentre11002','assCentre11003','assCentre11004','assCentre11005','assCentre11006','assCentre11007','assCentre11008','assCentre11009','assCentre11010','assCentre11011','assCentre11012','assCentre11013','assCentre11014','assCentre11016','assCentre11017','assCentre11018','assCentre11020', 'assCentre11021')
dataAC = read.table(acFile, header=1, sep=',')
dataAC = dataAC[,c('eid', acs)]
print(colnames(dataAC))

dataExp = read.table(expFile, header=1, sep=',')
dataExp = dataExp[,c('eid','snpScore96')]
print(colnames(dataExp))

dataConf = read.table(confFile, header=1, sep=',')
print(colnames(confFile))

####
#### merge data

alldata=merge(dataAC, dataExp, by='eid', all=FALSE)
alldata=merge(alldata, dataConf, by='eid', all=FALSE)

print(colnames(alldata))


#alldata=alldata[,c(14:32, 138:181)] 

pcs = c('pc1', 'pc2', 'pc3', 'pc4', 'pc5', 'pc6', 'pc7', 'pc8', 'pc9', 'pc10', 'pc11', 'pc12', 'pc13', 'pc14', 'pc15', 'pc16', 'pc17', 'pc18', 'pc19', 'pc20', 'pc21', 'pc22', 'pc23', 'pc24', 'pc25', 'pc26', 'pc27', 'pc28', 'pc29', 'pc30', 'pc31', 'pc32', 'pc33', 'pc34', 'pc35', 'pc36', 'pc37', 'pc38', 'pc39', 'pc40')
ac = as.matrix(alldata[,acs])
ageSex = alldata[,c('x31_0_0', 'x21022_0_0')]
ageSex10Pcs = alldata[,c('x31_0_0', 'x21022_0_0', pcs[1:10])]
ageSex40Pcs = alldata[,c('x31_0_0', 'x21022_0_0', pcs)]

####
#### ASSESSMENT CENTRE

# USE MERGED ASSESSMENT CENTRES

ac = as.matrix(alldata[,acs])

print(colnames(ac))

####
#### basic - adj for age and sex

fit <- lm(alldata$snpScore96 ~ ac + ., data=ageSex)
fitB <- lm(alldata$snpScore96 ~ ., data=ageSex)
lres = lrtest(fit, fitB)
modelP = lres[2,"Pr(>Chisq)"];
print(paste("AC adj age, sex:", modelP))

####
#### 10 pcs

fit <- lm(alldata$snpScore96 ~ ac + ., data=ageSex10Pcs)
fitB <- lm(alldata$snpScore96 ~ ., data=ageSex10Pcs)
lres = lrtest(fit, fitB)
modelP = lres[2,"Pr(>Chisq)"];
print(paste("AC	adj age, sex, 10 pcs:", modelP))

####
#### 40 pcs

fit <- lm(alldata$snpScore96 ~ ac + ., data=ageSex40Pcs)
fitB <- lm(alldata$snpScore96 ~ ., data=ageSex40Pcs)
lres = lrtest(fit, fitB)
modelP = lres[2,"Pr(>Chisq)"];
print(paste("AC	adj age, sex, 40 pcs:", modelP))


####
#### Check if direction of association is consistent with selection induced collider bias


## Bristol - highest participation rate

# age sex only
fit <- lm(alldata$snpScore96 ~ ac[,"assCentre11011"] + ., data=ageSex)
ci <- confint(fit)
print(ci)

# 10 pcs
fit <- lm(alldata$snpScore96 ~ ac[,"assCentre11011"] + ., data=ageSex10Pcs)
ci <- confint(fit)
print(ci)

# 40 pcs
fit <- lm(alldata$snpScore96 ~ ac[,"assCentre11011"] + ., data=ageSex40Pcs)
ci <- confint(fit)
print(ci)

## Glasgow - lowest participation rate

# age sex only
fit <- lm(alldata$snpScore96 ~ ac[,"assCentre11004"] + ., data=ageSex)
ci <- confint(fit)
print(ci)

# 10 pcs
fit <- lm(alldata$snpScore96 ~ ac[,"assCentre11004"] + ., data=ageSex10Pcs)
ci <- confint(fit)
print(ci)

# 40 pcs
fit <- lm(alldata$snpScore96 ~ ac[,"assCentre11004"] + ., data=ageSex40Pcs)
ci <- confint(fit)
print(ci)




 sink()
