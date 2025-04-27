#!/bin/bash

# Realiza un shell-script que realice una división de dos números que se
# pasen por parámetro por el método de las restas.
#
# Método de las restas:
# 
# 9/4 =>
# 9 - 4 = 5
# 5 - 4 = 1
# 
# He hecho dos restas, luego 9/4 es dos, con resto 1. En este ejercicio,
# el resto se obvia.

if [ $# -ne 2 ]; then
	echo "No se han introducido dos parámetros"
	exit 1
fi

for i in $@; do
	if ! [[ $i =~ ^[+-]?[0-9]+$ ]]; then
		echo "$i no es un número"
		exit 1
	fi
done

if [ $2 -eq 0 ]; then
	echo "No se puede realizar una división entre 0"
	exit 1
fi

cociente=0
divisor=$1
dividendo=$2
while [ $divisor -ge $dividendo ]; do
	resultado=$(($divisor - $dividendo))
	echo "$divisor - $dividendo = $resultado"
	divisor=$resultado
	((cociente++))
done
echo "El cociente de $1 / $dividendo = $cociente"
