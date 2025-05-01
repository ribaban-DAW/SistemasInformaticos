#!/bin/bash

# Realizar un Shell-script que reciba dos parámetros. El primero será un
# fichero y el segundo, un número entero N. El Shell-script mostrará las
# primeras N líneas del fichero. Se debe comprobar el número de parámetros
# y que se pueda acceder al fichero.

if [ $# -ne 2 ]; then
	echo "No se han introducido 2 parámetros"
	exit 1
fi

if [ -e $1 ] && [ -f $1 ]; then
	if [[ $2 =~ ^[+]?[0-9]+$ ]]; then
		head -$2 $1
	fi
fi
