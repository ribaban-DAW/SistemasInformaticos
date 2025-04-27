#!/bin/bash

# Programa que reciba tres palabras como parámetros y las visualice al revés.

if [ $# -ne 3 ]; then
	exit 1
fi

echo $3 $2 $1
