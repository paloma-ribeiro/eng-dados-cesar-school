#!/bin/bash

echo "Digite um número: "
read numero

for ((i = 1; i <= $numero; i++)); do

	if [ $numero -gt 2 ]; then
		echo "Iterando..."
		top -n $i > iteracao-$i.log
	else
		echo "Não será necessário!"
		break
	fi
done

echo "Criando a pasta backup_par"
mkdir -p backup_par

echo "Criando a pasta backup_impar"
mkdir -p backup_impar

echo "Transferindo os arquivos impares para a pasta backup_impar e os arquivos pares para a pasta backup_par"

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

echo "Criando a pasta backup_par_impar, para compactação dos diretórios"
mkdir -p backup_par_impar

echo "Movendo as pastas backup_par e backup_impar para a pasta backup_par_impar"
mv backup_par backup_par_impar
mv backup_impar backup_par_impar

echo "Compactando a pasta backup_par_impar"
tar -czf backup_par_impar.tar.gz backup_par_impar/

echo "Fim do script!"
