#!/bin/bash

# Implementar un shell-script que mueva todos los ficheros que se le pasen por
# parámetro, y para los que tengamos permiso, al directorio Backup.

for i in $@; do
	if [ -e $i ] && [ -r $i ] && [ -w $i ]; then
		mkdir -p Backup
		mv $i Backup
	fi
done
