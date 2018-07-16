#####
# make the statistics needed for mr-egger
#####

# read data
dataDir=Sys.getenv('PROJECT_DATA')
data = read.table(paste(dataDir,'/phenotypes/derived/nervous-dataset97.csv',sep=''), header=1, sep=',')

source("assocForEgger.r")

assocForEgger("x1970_0_0", data)
assocForEgger("x1980_0_0", data)
assocForEgger("x1990_0_0", data)
assocForEgger("x2010_0_0", data)


