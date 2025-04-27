#!/bin/bash

# Programa llamado existe al que se le pasa como parámetro un fichero y dice si existe,
# no existe o es un directorio.

if [ $# -ne 1 ]; then
	echo "Tienes que introducir un parámetro"
	exit 1
fi

if [ -e $1 ]; then
	echo "'$1' existe"
else
	echo "'$1' no existe"
fi

if [ -d $1 ]; then
	echo "Además, '$1' es un directorio"
fi
