

for i in {1..200}
do
	cp j-template.sh j-p${i}-200.sh
	sed -i "s/IDX/${i}/g" j-p${i}-200.sh

done
