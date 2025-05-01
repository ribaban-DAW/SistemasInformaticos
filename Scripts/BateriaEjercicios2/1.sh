#!/bin/bash

# Realiza un shell-script que comprueba si el fichero pasado por parámetro tiene
# permisos de lectura, en cuya caso, mostrará el contenido de forma paginada.

if [ $# -eq 1 ]; then
	if [ -r $1 ]; then
		cat $1 | less
	else
		echo "El fichero no tiene permisos de lectura"
	fi
else
	echo "El fichero no existe"
fi
