#!/bin/bash

# Ejecutar el siguiente menú para cada uno de los archivos/directorios que se
# introducirán como parámetros. Los archivos/directorios pueden estar en
# cualquier lugar de la estructura de directorios (/).
# 
# Realizar las comprobaciones necesarias e introducir comentarios que
# faciliten la comprensión del programa.
# 
# Ejemplo de ejecución:
# ./Ej1.sh directorio1 directorio2 archivo1 directorio3 archivo2…
# 
# Menú:
# a) Visualizar la ruta del fichero/directorio <nombre>
# b) Visualizar el contenido del fichero/directorio <nombre>
# c) Visualizar los permisos del fichero/directorio <nombre>
# Elige opción (a, b, c):

function visualizar_ruta()
{
	# https://stackoverflow.com/questions/5265702/how-to-get-full-path-of-a-file
	echo $(realpath $1)
}

function visualizar_contenido()
{
	if ! [ -e $1 ]; then
		echo "'$1' no existe"
		return
	fi

	if [ -d $1 ]; then
		ls $1
		return
	fi

	if [ -r $1 ]; then
		cat $1
	fi
}

function visualizar_permisos()
{
	if ! [ -e $1 ]; then
		echo "'$1' no existe"
		return
	fi

	ls -la $(dirname $1) | grep $(basename $1) | cut -d " " -f 1
}

function mostrar_menu()
{
	echo "a) Visualizar la ruta del fichero/directorio '$1'"
	echo "b) Visualizar el contenido del fichero/directorio '$1'"
	echo "c) Visualizar los permisos del fichero/directorio '$1'"
}

if [ $# -eq 0 ]; then
	echo "Ejemplo de ejecución:"
	echo "./$0 directorio1 directorio2 archivo1 directorio3 archivo2…"
	exit 1
fi

for i in $@; do
	mostrar_menu $i
	read -p "Elige opción (a, b, c): " opcion
	case $opcion in
		"a")
			visualizar_ruta $i
			;;
		"b")
			visualizar_contenido $i
			;;
		"c")
			visualizar_permisos $i
			;;
		*)
			echo "Opción inválida"
			;;
	esac
done
