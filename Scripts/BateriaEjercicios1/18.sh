#!/bin/bash

# Implementa un shell-script que compruebe si los ficheros pasados
# por parámetro existen. Si existen, se muestra el nombre del
# fichero, si no existen, se muestra un mensaje de error.

for i in $@; do
	if [ -e $i ]; then
		echo "$i"
	else
		>&2 printf "\033[31m[ERROR]\033[0m El fichero '$i' no existe\n"
	fi
done
