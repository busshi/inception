#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"

DIR=${ADMINER_PATH}


check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || echo -e "$KO"
}



echo -e "${orange}[+] Copying adminer files...${clear}"
for file in "index.php" "adminer.css" ; do
	if [ -f "$file" ] ; then
		mv "$file" "$DIR/"
		check
	else
		echo -e "${OK} File ${file} for adminer already copied. Skipping."
	fi
done


echo -e "${orange}[+] Checking adminer config file www.conf...${clear}"
file="www.conf"
if [ -f "$file" ] ; then
	sed -i "s/ADMINER_PORT/${ADMINER_PORT}/" "$file"
	mv "$file" /etc/php7/php-fpm.d/
	check
else
	echo -e "${OK} www.conf for adminer already copied. Skipping."
fi


echo -e "${orange}[+] Copying nginx-adminer configuration file...${clear}"
config="default.conf"
if [ -f "$config" ] ; then
	sed -i "s/DOMAIN_URL/${DOMAIN_URL}/g" "$config"
	path=$(echo ${DIR} | sed 's_/_\\/_g')
	sed -i "s/ADMINER_PATH/${path}/g" "$config"
	sed -i "s/ADMINER_HOST/${ADMINER_HOST}/g" "$config"
	sed -i "s/ADMINER_PORT/${ADMINER_PORT}/g" "$config"
	mv "$config" /etc/nginx/http.d/
	check
else
	echo -e "${OK} Nginx-adminer config file already copied. Skipping."
fi


echo -e "${orange}[+] Running php-fpm daemon for adminer...${clear}"
php-fpm7
check


echo -e "${orange}[+] Checking nginx-adminer configuration...${clear}"
nginx -t
check


echo -e "${orange}[+] Running nginx for adminer...${clear}"
nginx -g "daemon off;"


