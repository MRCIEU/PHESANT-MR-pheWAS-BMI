

for i in $(seq 1 1 22)
do 
	cp j-template.sh j${i}.sh
	sed -i "s/CHR/${i}/g" j${i}.sh
done
