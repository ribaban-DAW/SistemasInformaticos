#!/bin/bash

# Implementa un shell-script que cree un fichero de nombre Copia.bkp,
# donde se almacenen comprimidos todos los ficheros que se pasen por parámetro.

if [ $# -ne 0 ]; then
	tar -cf Copia.bkp $@ 2> /dev/null
fi
