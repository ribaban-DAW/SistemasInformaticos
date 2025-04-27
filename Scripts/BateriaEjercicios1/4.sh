#!/bin/bash

# Programa que reciba dos números y diga cuál es el mayor.

if [ $# -ne 2 ]; then
	echo "No se han introducido 2 parámetros"
	exit 1
fi

for i in $@; do
	# Nota: El regex no hay que entrecomillarlo o no funciona
	if ! [[ "$i" =~ ^[+-]?[0-9]+$ ]]; then
		echo "$i no es un número"
		exit 1
	fi
done

if [ $1 -gt $2 ]; then
	echo $1
elif [ $2 -gt $1 ]; then
	echo $2
fi
