#!/bin/bash

# Realiza un shell-script que muestre el nombre de cada uno de los ficheros
# pasados por parámetro y visualice su contenido por pantalla.

for i in $@; do
	if [ -e $i ]; then
		echo "El contenido de $i es:"
		if [ -d $i ]; then
			ls $i
		else
			cat $i
		fi
	fi
done
