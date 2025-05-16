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
	letra=$(echo $1 | cut -d ":" -f 3 | cut -b 1-1)
	ap1=$(echo $1 | cut -d ":" -f 1 | cut -b 1-3)
	ap2=$(echo $1 | cut -d ":" -f 2 | cut -b 1-3)
	num=$(echo $1 | cut -d ":" -f 4 | cut -b 6-8)
	# Convertir a minúsculas
	# https://stackoverflow.com/a/2264537
	usuario=$(echo "$letra$ap1$ap2$num" | tr '[:upper:]' '[:lower:]')
	echo $usuario
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

for i in $(cat $archivo); do
	generar_usuario $i
done
