#!/bin/bash

# Implementar un shell-script que copie todos los ficheros que se le pasen
# por parámetro, al directorio Seguridad. Si directorio no existe, se deberá crear.

if [ $# -eq 0 ]; then
	echo "No se han introducido ficheros"
	exit 1
fi

seguridad_dir=$(dirname $0)/Seguridad
for i in $@; do
	if [ -e $i ]; then
		mkdir -p $seguridad_dir
		cp -R $i $seguridad_dir
		echo "Se ha copiado el fichero '$i' a $seguridad_dir"
	else
		echo "El fichero '$i' no existe"
	fi
done
