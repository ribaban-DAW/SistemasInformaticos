#!/bin/bash

# Realiza un shell-script, que calcule la potencia de un número.
# El shell pedirá la base y el exponente, devolviendo la potencia.

read -p "Introduce la base: " base
if ! [[ "$base" =~ ^[+-]?[0-9]+$ ]]; then
	echo "La base no es un número"
	exit 1
fi

read -p "Introduce la exponente: " exponente
if ! [[ "$exponente" =~ ^[+]?[0-9]+$ ]]; then
	echo "El exponente solo puede ser un número positivo"
	exit 1
fi

potencia=1
for (( i=0; i < $exponente; i+=1 )); do
	potencia=$(($potencia * $base))
done

echo "$base^$exponente = $potencia"
