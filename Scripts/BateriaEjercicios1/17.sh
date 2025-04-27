#!/bin/bash

# Realiza un shell-script, que pida dos números por teclado.
# El programa pintará tantos *, como indique el número mayor de
# los dos introducidos.

read -p "Introduce el primer número: " num1
if ! [[ "$num1" =~ ^[+]?[0-9]+$ ]]; then
	echo "El número tiene que ser positivo"
	exit 1
fi

read -p "Introduce el segundo número: " num2
if ! [[ "$num2" =~ ^[+]?[0-9]+$ ]]; then
	echo "El número tiene que ser positivo"
	exit 1
fi

cantidad=$num2
if [ $num1 -gt $num2 ]; then
	cantidad=$num1
fi

for ((i=0; i<$cantidad; i+=1)); do
	echo -n "*"
done
echo
