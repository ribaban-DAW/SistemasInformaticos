#!/bin/bash

# Programa que reciba dos números como parámetro y devuelva la suma si
# el primero es mayor que el segundo y la resta en caso contrario.

if [ $# -ne 2 ]; then
	echo "No se han introducido 2 parámetros"
	exit 1
fi

for i in $@; do
	if ! [[ "$i" =~ ^[+-]?[0-9]+$ ]]; then
		echo "$i no es un número"
		exit 1
	fi
done

if [ $1 -gt $2 ]; then
	echo $(($1 + $2))
else
	echo $(($1 - $2))
fi
