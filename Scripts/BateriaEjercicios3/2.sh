#!/bin/bash

# Crea un archivo llamado “usuarios.txt” con los siguientes datos
# (los datos pueden ser inventados, pero alfanuméricos):
# [apellido1:apellido2:nombre:dni]. Suponemos DNI de 8 cifras iniciales
# y una letra final. No es necesario tratar los caracteres con tilde,
# ni es necesario introducir una letra válida de DNI. Ejemplo:
#
#     Atienza:Gonzalez:Gloria:31234567T
#     Lorenzo:Garrido:Francisco:91234123S
#     Ferrer:Davila:Mario:11234648E
#
# El script se llamará ej2.sh y deberá coger del archivo “usuarios.txt”
# la primera letra del nombre, las tres primeras letras del primer apellido,
# las tres primeras letras del segundo apellido y los tres últimos dígitos del
# DNI sin incluir la letra. El resultado lo mostrará por pantalla y todo
# debe mostrarse en minúsculas.
# 
# Ejemplo de resultado partiendo del fichero con los datos anteriores:
#
#     gatigon567
#     florgar123
#     mferdav648

function generar_usuario()
{
	IFS=:

	counter=1
	for i in $1; do
		case $counter in
			1)
				ap1=$(echo "$i" | cut -c 1-3)
				;;
			2)
				ap2=$(echo "$i" | cut -c 1-3)
				;;
			3)
				letra=$(echo "$i" | cut -c 1)
				;;
			4)
				num=$(echo "$i" | cut -c 1-3)
				;;
		esac
		((counter++))
	done
	# Convertir a minúsculas
	# https://stackoverflow.com/a/2264537
	usuario=$(echo "$letra$ap1$ap2$num" | tr '[:upper:]' '[:lower:]')
	echo $usuario

	# Restablezco el delimitador, porque sino no obtiene los datos de los demás
	# usuarios correctamente
	IFS=
}

if [ $# -eq 0 ]; then
	echo "Usando el archivo por defecto 'usuarios.txt'"
	archivo="usuarios.txt"
else
	archivo="$1"
fi

if ! [ -e $archivo ]; then
	echo "El archivo '$archivo' no existe"
	exit 1
fi

# https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/
# Para leer un archivo línea por línea
while IFS= read -r line; do
	generar_usuario $line
done < $archivo
