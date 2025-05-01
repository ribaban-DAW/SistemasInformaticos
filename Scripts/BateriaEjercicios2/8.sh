#!/bin/bash

# Implementar un script que muestre el siguiente menú:
#
#     1 - Sumar
#     2 - Restar
#     3 - Dividir
#     4 – Multiplicar
#     0 - Salir
#
# • Después de mostrar el menú, se pedirá que se elija una opción.
#   Si la opción elegida no está entre el 1 y el 4, se mostrará un
#   mensaje de error. En caso de que la opción sea válida, se pedirán
#   dos números por teclado y en función de la operación elegida, se
#   devolverá el resultado por pantalla.
#
# • Cada operación será implementada haciendo uso de funciones.
#
# • Si la opción elegida no es válida, se volverá a mostrar el menú.
#
# • El programa terminará, cuando se pulse 0.

function suma()
{
	echo "$1 + $2 = $(($1+$2))"
}

function resta()
{
	echo "$1 - $2 = $(($1-$2))"
}

function multiplicacion()
{
	echo "$1 * $2 = $(($1*$2))"
}

function division()
{
	if [ $2 -eq 0 ]; then
		echo "No se puede dividir entre 0"
		return
	fi
	echo "$1 / $2 = $(($1/$2))"
}

function mostrar_menu()
{
	echo "1 - Sumar"
	echo "2 - Restar"
	echo "3 - Dividir"
	echo "4 - Multiplicar"
	echo "0 - Salir"
}

while true; do
	mostrar_menu
	read -p "> " opcion
	if ! [[ $opcion =~ ^[0-4]$ ]]; then
		echo "Opción inválida"
		continue
	fi
	if [ $opcion -eq 0 ]; then
		echo "Saliendo..."
		exit 0
	fi
	read -p "Introduce el número 1: " num1
	if ! [[ $num1 =~ ^[+-]?[0-9]+$ ]]; then
		echo "'$num1' no es un número"
		continue
	fi
	read -p "Introduce el número 2: " num2
	if ! [[ $num2 =~ ^[+-]?[0-9]+$ ]]; then
		echo "'$num2' no es un número"
		continue
	fi

	case $opcion in
		1)
			suma $num1 $num2
			;;
		2)
			resta $num1 $num2
			;;
		3)
			division $num1 $num2
			;;
		4)
			multiplicacion $num1 $num2
			;;
	esac
done
