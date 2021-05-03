#!/bin/sh

red="\033[0;31m"
green="\033[0;32m"
orange="\033[0;33m"
clear="\033[0;m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"


check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || echo -e "$KO"
}


echo -e "${orange}[+] Generating self certificat for nginx...${clear}"
if [ ! -f "${NGINX_CERT}" -o ! -f "${NGINX_CERT_KEY}" ] ; then
	mkdir -p ${CERT_PATH}
	openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=FRANCE/L=Paris/O=42fr/OU=42fr/CN=${WORDPRESS_DB_USER}" -newkey rsa:3072 -keyout ${NGINX_CERT_KEY} -out ${NGINX_CERT}
	check
else
	echo -e "${OK} Certificat already generated. Skipping."
fi


echo -e "${orange}[+] Copying nginx configuration file...${clear}"
config="default.conf"
if [ -f "$config" ] ; then
	sed -i "s/DOMAIN_URL/${DOMAIN_URL}/g" "$config"
	path=$(echo ${WORDPRESS_VOLUME_PATH} | sed 's_/_\\/_g')
	sed -i "s/WORDPRESS_VOLUME_PATH/${path}/g" "$config"
	sed -i "s/WORDPRESS_HOST/${WORDPRESS_HOST}/g" "$config"
	sed -i "s/WORDPRESS_PORT/${WORDPRESS_PORT}/g" "$config"
	mv "$config" /etc/nginx/http.d/
	check
else
	echo -e "${OK} Nginx config file already copied. Skipping."
fi


echo -e "${orange}[+] Checking nginx configuration...${clear}"
nginx -t
check


echo -e "${orange}[+] Running nginx...${clear}"
nginx -g "daemon off;"
