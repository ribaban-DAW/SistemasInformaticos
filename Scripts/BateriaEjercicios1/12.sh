#!/bin/bash

# Implementa un shell-script que indique si los ficheros pasados por parámetro
# existen y si son ficheros o directorios.

for i in $@; do
	if [ -e $i ]; then
		if [ -d $i ]; then
			echo "'$i' existe y además es un directorio"
		else
			echo "'$i' existe y es un fichero"
		fi
	else
		echo "'$i' no existe"
	fi
done
