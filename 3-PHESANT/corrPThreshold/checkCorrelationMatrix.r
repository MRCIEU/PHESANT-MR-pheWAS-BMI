


dataDir=paste(Sys.getenv('HOME'), '/2016-biobank-mr-phewas-bmi/data/sample500/', sep='')
corfile=paste(dataDir, 'phenotypes/derived/phesant-save/correlations/cor-all-nona.txt',sep='')

matrixall = read.table(corfile, header=0, sep=',')
mx = as.matrix(matrixall)

####
#### Checking the matrix

# should be 22879 x 22879
print(dim(mx))

# diagonal should be ones
print('diagonal all ones:')
x = diag(mx)
length(x)
ix = which(x!=1)
length(ix)



# random check of some indexes to check x(i,j) == x(j,i)
print("checking correlations are symmetrical about diagonal")
n=20
randidxi=runif(n, 1, 22879)
randidxi=round(randidxi)
randidxj=runif(n, 1, 22879)
randidxj=round(randidxj)

for (k in 1:n) {

	# values of i,j and j,i indexes in correlation matrix
	ijx = mx[randidxi[k], randidxj[k]]; 
	jix = mx[randidxj[k], randidxi[k]]; 


	isequal = ijx == jix; 
	print(paste(ijx, ' ' , jix, ' ', isequal);	
}


