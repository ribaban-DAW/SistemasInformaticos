#!/bin/bash

# Se va a simular que se añaden direcciones ips al fichero hosts. Para ello,
# si no existe, se creará un fichero llamado mock-hosts. Si ya existe,
# simplemente se añadirán líneas a ese fichero (al final del fichero).
# Se añadirán líneas de equipos teniendo en cuenta que toda la información
# necesaria se recibirá como parámetros:
#
# Parámetros 1 a 4: dirección IP inicial (formato xxx yyy zzz ttt)
# Parámetros 5 y siguientes (sin límite): nombres de host
# (ej: pc01 pc02 pcjuan pcpablo)
# 
# El Shell-script deberá cumplir las siguientes condiciones:
# - Se asignará la dirección IP inicial al primer equipo (host) de la lista.
# - La dirección IP de los demás será la del anterior más 1.
# - Se deberá controlar que no existe un equipo con la misma IP o el mismo
#   nombre en el fichero
# - Si hay alguno con la misma IP, se le sumará 1 y se volverá a comprobar
# - Si hay alguno con el mismo nombre se enviará este a un fichero llamado
#   errores.log y no se añadirá ninguna línea al fichero hosts.
#
# Control de errores:
# - Deberá comprobarse que el usuario invoca el Shell-script puede realizar
#   la tarea (es usuario root)
# - Deberá comprobarse que el número de parámetros es el adecuado para la
#   correcta ejecución del Shell-script
# - Si se produce cualquier error de los anteriores deberá cortarse la
#   ejecución mostrando un mensaje de error.
#
# Además, se tendrá en cuenta que:
# - Se va a utilizar direcciones IPV4 en formato XXX.YYY.ZZZ.TTT
# - Los equipos solo tienen un nombre por línea, esto es, en ninguna línea
#   una dirección IP tendrá asociados dos o más nombres.
# - Consideramos que los 4 primeros parámetros, si existen, son números entre
#   0 y 255, no es necesario comprobarlos.
#
# Ejemplo de ejecución
# ./Ej3.sh 25 26 27 253 h1 h2 h3 h4 h5
# Debería generar las líneas:
# 25.26.27.253 h1
# 25.26.27.254 h2
# 25.26.27.255 h3
# 25.26.28.0 h4
# 25.26.28.1 h5

# TODO:
# - Guardar los primeros cuatro parámetros en un array, así será más sencillo
#   parsear la ip?

function existe_ip_en_archivo()
{
	ip=$1
	archivo=$2
	while IFS= read -r line; do
		if [ "$ip" == "$(echo $line | cut -d " " -f 1)" ]; then
			return 1
		fi
	done < $archivo
	return 0
}

function existe_host_en_archivo()
{
	host=$1
	archivo=$2
	while IFS= read -r line; do
		if [ "$host" == "$(echo $line | cut -d " " -f 2)" ]; then
			return 1
		fi
	done < $archivo
	return 0
}

function incrementar_ip()
{
	octeto1=$(echo $1 | cut -d "." -f 1)
	octeto2=$(echo $1 | cut -d "." -f 2)
	octeto3=$(echo $1 | cut -d "." -f 3)
	octeto4=$(echo $1 | cut -d "." -f 4)

	((octeto4++))
	if [ $octeto4 -gt 255 ]; then
		((octeto3++))
		octeto4=0
	fi
	if [ $octeto3 -gt 255 ]; then
		((octeto2++))
		octeto3=0
	fi
	if [ $octeto2 -gt 255 ]; then
		((octeto1++))
		octeto2=0
	fi
	ip="$octeto1.$octeto2.$octeto3.$octeto4"
	return 0
}

function escribir_en_archivo()
{
	ip=$1
	host=$2
	archivo=$3

	while true; do
		existe_ip_en_archivo $ip $archivo
		if [ $? -eq 0 ]; then
			break
		fi
		incrementar_ip $ip
	done
	existe_host_en_archivo $host $archivo
	if [ $? -ne 0 ]; then
		echo "[$(date)] Error añadiendo host '$host'" >> errores.log
		return
	fi
	echo "$ip $host" >> $archivo
}

if [ $UID -ne 0 ]; then
	echo "Debe ser usuario root para ejecutar el script"
	exit 1
fi

if [ $# -lt 5 ]; then
	echo "Ejemplo de ejecución"
	echo "$0 25 26 27 253 h1 h2 h3 h4 h5"
	exit 1
fi

octeto1=$1
shift
octeto2=$1
shift
octeto3=$1
shift
octeto4=$1
shift
hosts=$@

ip="$octeto1.$octeto2.$octeto3.$octeto4"

if [ -e "hosts" ]; then
	archivo="hosts"
else
	archivo="mock-hosts"
	touch $archivo
fi

for i in $hosts; do
	escribir_en_archivo $ip $i $archivo
done
