#!/bin/bash

# Programa que visualice mensaje de error si no se le pasan parámetros.

if [ $# -eq 0 ]; then
	echo "No se han introducido parámetros"
	exit 1
fi
