#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"

DIR=${WEBSITE_PATH}


check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || echo -e "$KO"
}



echo -e "${orange}[+] Copying website page...${clear}"
if [ -f "index.html" ] ; then
	mv "index.html" "$DIR/"
	check
else
	echo -e "${OK} Website page already copied. Skipping."
fi


echo -e "${orange}[+] Checking website config file www.conf...${clear}"
file="www.conf"
if [ -f "$file" ] ; then
	sed -i "s/WORDPRESS_PORT/${WORDPRESS_PORT}/" "$file"
	mv "$file" /etc/php7/php-fpm.d/
	check
else
	echo -e "${OK} Website file www.conf already copied. Skipping."
fi


echo -e "${orange}[+] Copying nginx-website configuration file...${clear}"
config="default.conf"
if [ -f "$config" ] ; then
	sed -i "s/DOMAIN_URL/${DOMAIN_URL}/g" "$config"
	path=$(echo ${DIR} | sed 's_/_\\/_g')
	sed -i "s/WEBSITE_PATH/${path}/g" "$config"
	sed -i "s/WEBSITE_HOST/${WEBSITE_HOST}/g" "$config"
	sed -i "s/WEBSITE_PORT/${WEBSITE_PORT}/g" "$config"
	sed -i "s/WORDPRESS_PORT/${WORDPRESS_PORT}/g" "$config"
	mv "$config" /etc/nginx/http.d/
	check
else
	echo -e "${OK} Nginx-website config file already copied. Skipping."
fi


echo -e "${orange}[+] Running php-fpm daemon for the website...${clear}"
php-fpm7
check


echo -e "${orange}[+] Checking nginx-website configuration...${clear}"
nginx -t
check


echo -e "${orange}[+] Running nginx for the website...${clear}"
nginx -g "daemon off;"


