subnetting: subnetting.c
	clang -Wall -Wextra -Werror subnetting.c -o subnetting

clean:
	rm -f subnetting

.PHONY: subnetting clean
