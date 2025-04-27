#!/bin/bash

# Realiza un shell-script que permita recibir, al menos, dos parámetros.
# El primero serán opciones, y el segundo un fichero. Si el primer parámetro
# es -e, el Shell ejecutará el programa que se pasa como segundo parámetro,
# si el primer parámetro es -m, el shell mostrará el contenido del fichero pasado
# como segundo parámetro.

if [ $# -lt 2 ]; then
	echo "Hay que introducir al menos 2 parámetros"
	exit 1
fi

case $1 in
	"-e")
		if [ -e $2 ]; then
			if [ -x $2 ]; then
				programa=$2
				shift
				shift
				./$programa $@
			else
				echo "'$2' no tiene permisos de ejecución"
			fi
		else
			echo "'$2' no existe"
		fi
		;;
	"-m")
		if [ -e $2 ]; then
			echo "El contenido de $2 es:"
			if [ -d $2 ]; then
				ls $2
			else
				cat $2
			fi
		else
			echo "'$2' no existe"
		fi
		;;
	*)
		echo "La flag no es válida, prueba '-e' o '-m'"
esac
