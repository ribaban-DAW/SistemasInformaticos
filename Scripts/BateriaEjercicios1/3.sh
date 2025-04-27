#!/bin/bash

# Programa que visualice un mensaje de error si no se le pasan parámetros,
# y que los visualice si se le pasan.

if [ $# -eq 0 ]; then
	echo "No se han introducido parámetros"
	exit 1
fi

echo $@
