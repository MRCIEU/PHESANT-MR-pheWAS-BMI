
# proof of principal association - effect of bmi on risk of diabetes diagnosed by doctor (field id 2443)

require(lmtest)
require(MASS)

resDir=Sys.getenv('RES_DIR')
dataDir=Sys.getenv('PROJECT_DATA')


# file to store output
sink(paste(resDir,'/proof_of_principle_out.txt',sep=''), append=FALSE, split=FALSE)


####
#### data file names

outcomeFile=paste(dataDir,'/phenotypes/derived/data.11148-phesant_header-proofofprinciple.csv',sep='')

expFile=paste(dataDir,'/snps/snp-score96-withPhenIds-subset.csv',sep='')
confFile=paste(dataDir,'/phenotypes/derived/confounders-PHESANT-pcs.csv',sep='')




####
#### load data

dataOutcomes = read.table(outcomeFile, header=1, sep=',')
print(colnames(dataOutcomes))

dataExp = read.table(expFile, header=1, sep=',')
dataExp = dataExp[,c('eid','snpScore96')]
print(colnames(dataExp))

dataConf = read.table(confFile, header=1, sep=',')
print(colnames(confFile))


####
#### merge data

alldata=merge(dataOutcomes, dataExp, by='eid', all=FALSE)
alldata=merge(alldata, dataConf, by='eid', all=FALSE)

print(colnames(alldata))


pcs = c('pc1', 'pc2', 'pc3', 'pc4', 'pc5', 'pc6', 'pc7', 'pc8', 'pc9', 'pc10')
confs = alldata[,c('x31_0_0', 'x21022_0_0', pcs[1:10])]


####
#### remove missing codes from diabetes variable

alldata$x2443_0_0[which(alldata$x2443_0_0==-3)] = NA
alldata$x2443_0_0[which(alldata$x2443_0_0==-1)] = NA
unique(alldata$x2443_0_0)

alldata$x2385_0_0[which(alldata$x2385_0_0==-3)] = NA
alldata$x2385_0_0[which(alldata$x2385_0_0==-1)] = NA
unique(alldata$x2385_0_0)

alldata$x2385_0_0 = as.factor(alldata$x2385_0_0)
 
####
#### standardise BMI genetic score

print("SD of genetic score")
print(sd(alldata$snpScore96))
alldata$snpScore96 = scale(alldata$snpScore96)
print(sd(alldata$snpScore96))

####
#### test of association
# direct test of BMI genetic instrument with diabetes
# diabetes fid=2443

mylogit <- glm(alldata$x2443_0_0 ~ alldata$snpScore96 + ., data=confs, family="binomial")
sumx = summary(mylogit)
pvalue = sumx$coefficients['alldata$snpScore96','Pr(>|z|)']
beta = sumx$coefficients["alldata$snpScore96","Estimate"]
cis = confint(mylogit, "alldata$snpScore96", level=0.95)
lower = cis["2.5 %"]
upper = cis["97.5 %"]
print(paste('log odds: ', beta, ' [', lower, ',', upper, ']'))
print(paste('odds: ', exp(beta), ' [', exp(lower), ',', exp(upper), ']'))

sink()








