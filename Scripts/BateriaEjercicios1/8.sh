#!/bin/bash

# Realiza un shell-script que muestre todos los números pares,
# desde el 0 hasta el 100.

for i in {0..50}; do
	if [ $i -eq 50 ]; then
		echo "$((i * 2))"
	else
		echo -n "$((i * 2)), "
	fi
done
