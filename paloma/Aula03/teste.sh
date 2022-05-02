arquivos=$(ls *.log)
i=1


for arquivo in $arquivos; do

	if [[ $i =~ ^[0-9]*[02468]$ ]]; then
		if [ $arquivo == "iteracao-$i.log" ]; then
			cp $arquivo ./backup_par
		fi
	else
		if [ $arquivo == "iteracao-$i.log" ]; then
			cp $arquivo ./backup_impar
		fi
	fi

	i=$((i+1))
done
