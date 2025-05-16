#!/bin/bash

# Realizar un script con la siguiente sintaxis.
#     ej7.sh [opciones] [argumentos]
#
# Al ejecutar el shell-script, este deberá mostrar el nombre del usuario
# que lo ejecuta. Las opciones que puede recibir el shell son las
# siguientes:
#
# Sin opciones ni argumentos, deberá mostrar el contenido del propio
# Shell-script.
#
# -m Comprobará que los argumentos (tras -m) son ficheros, en cuyo
# caso muestra su contenido por pantalla.
# 
# -x Deberá comprobar que los argumentos (tras -x) son programas
# ejecutables, en cuyo caso los ejecutará.
# 
# -p Mostrará los propietarios de los ficheros que se reciben por parámetro.

if [ $# -eq 0 ]; then
	cat $0
	exit 0
fi

case $1 in
	"-m")
		shift
		for i in $@; do
			if [ -f $i ]; then
				cat $i
			fi
		done
		;;
	"-x")
		shift
		for i in $@; do
			if [ -x $i ]; then
				./$i
			fi
		done
		;;
	"-p")
		shift
		for i in $@; do
			# https://www.ibm.com/docs/no/aix/7.2?topic=l-ls-command#ls_command__title__5
			# El tercero es la columna del propietario
			ls -l $i | cut -d " " -f 3
		done
		;;
	*)
		echo "La opción '$1' no existe"
		;;
esac
