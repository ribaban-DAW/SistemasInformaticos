#!/bin/bash

# Realiza un shell-script que reciba por teclado el nombre de un directorio.
# Si el directorio no existe, mostrará un mensaje de error, y si existe,
# mostrará un listado de sus archivos.

read -p "Introduce el nombre del directorio: " nombre_directorio

if [ -e $nombre_directorio ]; then
	if [ -d $nombre_directorio ]; then
		ls $nombre_directorio
	fi
else
	>&2 echo "El directorio no existe"
fi
