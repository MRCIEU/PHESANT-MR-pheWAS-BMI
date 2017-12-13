

for i in $(seq 1 1 22)
do 
	qsub j${i}.sh
	sleep 3
done
