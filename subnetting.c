#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <regex.h>
#include <stdint.h>

typedef uint8_t  u8;
typedef int32_t i32;

typedef enum
{
	CLASS_A,
	CLASS_B,
	CLASS_C,
	MAX_CLASS,
	INVALID_CLASS = -1,
} ClassType;

typedef struct
{
	char			*address;
	char			*submask;
	char			*broadcast;
	char			*host;
	ClassType		class;
	u8 				octet[4];
} Ip;

static bool	validate_ip(const char *ip)
{
	regex_t reg;
	const char *pattern = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2([0-4][0-9]|5[0-5]))\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2([0-4][0-9]|5[0-5]))$";
	if (regcomp(&reg, pattern, REG_EXTENDED) != 0) return (false);
	bool is_valid = regexec(&reg, ip, 0, NULL, 0) == 0;
	regfree(&reg);
	return (is_valid);
}

static bool	convert_ip_to_octets(const char *ip, u8 *octets)
{
	size_t offset = 0;
	for (size_t i = 0; i < 4; ++i)
	{
		size_t octet_len = strchr(ip + offset, '.') - (ip + offset);
		if (i == 3) octet_len = strlen(ip + offset);
		char buf[4] = {0};
		memcpy(buf, ip + offset, octet_len);
		octets[i] = atoi(buf);
		offset += octet_len + 1;
	}
	return (true);
}

static char	*convert_octets_to_ip(u8 *octets)
{
	char buf[16] = {0};
	size_t k = 0;
	for (size_t i = 0; i < 4; ++i)
	{
		k += snprintf(&buf[k], sizeof(buf) - k, "%u", octets[i]);
		if (i < 3) buf[k++] = '.';
	}
	return (strdup(buf));
}

static ClassType	get_class(u8 *octets)
{
	if (octets[0] >= 0 && octets[0] < 128) return (CLASS_A);
	else if (octets[0] >= 128 && octets[0] < 192) return (CLASS_B);
	else if (octets[0] >= 192 && octets[0] < 224) return (CLASS_C);
	return (INVALID_CLASS);
}

static char	*get_submask(ClassType class)
{
	if (class == CLASS_A) return (strdup("255.0.0.0"));
	else if (class == CLASS_B) return(strdup("255.255.0.0"));
	else if (class == CLASS_C) return(strdup("255.255.255.0"));
	else return (NULL);
}

static char	*get_host(Ip *ip)
{
	u8	octets[16];
	memcpy(octets, ip->octet, 16);
	if (ip->class == CLASS_A) memset(octets + 1, 0, 3);
	else if (ip->class == CLASS_B) memset(octets + 2, 0, 2);
	else if (ip->class == CLASS_C) memset(octets + 3, 0, 1);
	return (convert_octets_to_ip(octets));
}

static char	*get_broadcast(Ip *ip)
{
	u8	octets[16];
	memcpy(octets, ip->octet, 16);
	if (ip->class == CLASS_A) memset(octets + 1, 255, 3);
	else if (ip->class == CLASS_B) memset(octets + 2, 255, 2);
	else if (ip->class == CLASS_C) memset(octets + 3, 255, 1);
	return (convert_octets_to_ip(octets));
}

static bool	fill_ip(Ip *ip, const char *s)
{
	if (!ip || !s || !validate_ip(s)) return (false);
	ip->address = strdup(s);
	if (!ip->address) return (false);
	if (!convert_ip_to_octets(ip->address, ip->octet))
	{
		free(ip->address);
		return (false);
	}
	ip->class = get_class(ip->octet);
	ip->submask = get_submask(ip->class);
	ip->host = get_host(ip);
	ip->broadcast = get_broadcast(ip);
	if (!ip->host || !ip->broadcast || !ip->submask || ip->class == INVALID_CLASS)
	{
		free(ip->address);
		free(ip->broadcast);
		free(ip->host);
		free(ip->submask);
		return (false);
	}
	return (true);
}

static void	print_ip(Ip *ip)
{
	printf("           IP Details\n");
	for (size_t i = 0; i < 32; ++i) printf("="); printf("\n");
	printf("    Address:   %s\n", ip->address);
	printf("    Submask:   %s\n", ip->submask);
	printf("    Host:      %s\n", ip->host);
	printf("    Broadcast: %s\n", ip->broadcast);
	if (ip->class == CLASS_A) printf("    Class:     A\n");
	else if (ip->class == CLASS_B) printf("    Class:     B\n");
	else if (ip->class == CLASS_C) printf("    Class:     C\n");
	else printf("    Class:     Undefined\n");
	for (size_t i = 0; i < 32; ++i) printf("="); printf("\n");
}

static void print_ip_bits(Ip *ip)
{
	printf("%s -> ", ip->address);
	for (i32 i = 0; i < 4; ++i)
	{
		for (i32 j = 7; j >= 0; --j)
			printf("%d", (ip->octet[i] >> j) & 1);
		if (i < 3) printf(".");
		else printf("\n");
	}
}

static void	clean_ip(Ip *ip)
{
	free(ip->address);
	free(ip->broadcast);
	free(ip->host);
	free(ip->submask);
}

i32	main(i32 argc, char **argv)
{
	char *address = "192.168.0.1";
	if (argc > 1) address = argv[1];
	Ip ip;
	if (!fill_ip(&ip, address))
	{
		fprintf(stderr, "%s is an invalid IP address\n", address);
		return (EXIT_FAILURE);
	}
	print_ip(&ip);
	print_ip_bits(&ip);
	clean_ip(&ip);
	return (EXIT_SUCCESS);
}
