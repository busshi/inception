#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"

DIR="/home/aldubar/data/wordpress"

keep_alive()
{
echo -e "[+]${orange} Starting php-fpm${clear}"
wp --info
php-fpm7 -F
}

config_fail()
{
echo -e "${KO} Config failed"
echo "failed" > ${file}
exit 1
}

check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || config_fail
}

sleep 15

echo -e "${orange}[+] Checking wordpress config...${clear}"
file="${DIR}/config.txt"
[ -f "$file" ] && check_config=$( cat "$file" )
[ "$check_config" = "done" ] && { echo -e "${OK} Config already done! Skipping..."; keep_alive; } || echo "Need to configure wordpress..."

echo -e "${orange}[+] Configuring wordpress...${clear}"
wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${WORDPRESS_DB_HOST}
check

echo -e "${orange}[+] Creating supervisor user and a sample wordpress site${clear}"
wp core install --url="test.42.fr" --title="Site test 42" --admin_user=${WORDPRESS_DB_ADMIN} --admin_password=${WORDPRESS_DB_ADMIN_PASSWORD} --admin_email="${WORDPRESS_DB_ADMIN}@42.fr"
check


#echo -e "${orange}[+] Giving admin super-admin privileges${clear}"
#wp super-admin add "${WORDPRESS_DB_ADMIN}"
#check

echo -e "${orange}[+] Creating wordpress user...${clear}"
wp user create ${WORDPRESS_DB_USER} "${WORDPRESS_DB_USER}@student.42.fr" --user_pass=${WORDPRESS_DB_USER_PASSWORD} --role=editor
check

echo -e "${orange}[+] Listing users:${clear}"
wp user list


keep_alive

