#!/bin/bash

# Implementa un shell-script, que permita intercambiar el nombre de 2 ficheros
# pasados por parámetro.

if [ $# -ne 2 ]; then
	echo "No se han introducido 2 parámetros"
	exit 1
fi

if [ -e $1 ] && [ -e $2 ]; then
	temp="$1.tmp"
	mv $1 $temp
	mv $2 $1
	mv $temp $2
fi
