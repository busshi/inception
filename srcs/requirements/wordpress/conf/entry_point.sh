#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"

DIR=${WORDPRESS_VOLUME_PATH}

error=0

keep_alive()
{
echo -e "${orange}[+] Listing users:${clear}"
wp user list

echo -e "${orange}[+} Listing existing posts:${clear}"
wp post list

echo -e "${orange}[+] Wordpress info:${clear}"
wp --info

echo -e "${orange}[+] Starting php-fpm${clear}"
php-fpm7 -F
}


config_fail()
{
echo -e "${KO} Config failed"
echo "failed" > ${file}
error=$(( $error + 1 ))
exit 1
}


check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || config_fail
}



sleep 5

echo -e "${orange}[+] Connecting to mariadb from wordpress...${clear}"
connected=0
while [[ $connected -eq 0 ]] ; do
	mariadb -h${WORDPRESS_DB_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} &> /dev/null
	[[ $? -eq 0 ]] && { connected=$(( $connected + 1 )); check; }
	sleep 1
done


echo -e "${orange}[+] Checking wordpress config...${clear}"
file="${DIR}/config.txt"
[ -f "$file" ] && check_config=$( cat "$file" )
[ "$check_config" = "done" ] && { echo -e "${OK} Config already done! Skipping..."; keep_alive; } || echo "Need to configure wordpress..."


echo -e "${orange}[+] Configuring wordpress...${clear}"
wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${WORDPRESS_DB_HOST}
check


echo -e "${orange}[+] Creating administrator ${WORDPRESS_DB_ADMIN} and a sample wordpress site${clear}"
wp core install --url="${DOMAIN_URL}" --title="Random Blog 42" --admin_user=${WORDPRESS_DB_ADMIN} --admin_password=${WORDPRESS_DB_ADMIN_PASSWORD} --admin_email="${WORDPRESS_DB_ADMIN}@42.fr"
check


#echo -e "${orange}[+] Giving admin super-admin privileges${clear}"
#wp super-admin add "${WORDPRESS_DB_ADMIN}"
#check


echo -e "${orange}[+] Creating wordpress user: ${WORDPRESS_DB_USER}...${clear}"
wp user create ${WORDPRESS_DB_USER} "${WORDPRESS_DB_USER}@student.42.fr" --user_pass=${WORDPRESS_DB_USER_PASSWORD} --role=editor
check

echo -e "${orange}[+] Cleaning sample post...${clear}"
wp post delete 1 --force
check


echo -e "${orange}[+] Generating some random posts...${clear}"
wp post create --post_type=post --post_name='1st_post' --post_title='Un post inutile...' --post_content='Voici un post inutile pour tester la base de données...' --post_author=2 --post_status=publish
check
wp post create --post_type=post --post_name='2nd_post' --post_title='Un post très inutile !' --post_content='Voilà un post encore plus inutile !' --post_author=2 --post_status=publish
check

[[ $error -eq 0 ]] && echo "done" > $file


keep_alive

