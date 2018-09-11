

cordir="${PROJECT_DATA}/phenotypes/derived/phesant-save/correlations/"

types=(cont bin catord)

> ${cordir}cor-all.txt

for i in {1..200}
do

	for typex in "${types[@]}"
	do
#		echo $typex
		filename="cormat-${i}-${typex}.txt"
		cat ${cordir}$filename >> ${cordir}cor-all.txt

	done
done
