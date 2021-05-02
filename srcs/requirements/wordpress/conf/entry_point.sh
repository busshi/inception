#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"

DIR=${WORDPRESS_VOLUME_PATH}


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



check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || { echo -e "${KO} Config failed!"; } #exit 1; }
}



sleep 5

echo -e "${orange}[+] Connecting to mariadb from wordpress...${clear}"
connected=0
while [[ $connected -eq 0 ]] ; do
	mariadb -h${WORDPRESS_DB_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} &> /dev/null
	[[ $? -eq 0 ]] && { connected=$(( $connected + 1 )); check; }
	sleep 1
done



echo -e "${orange}[+] Configuring wordpress...${clear}"
if [ ! -f "${DIR}/wp-config.php" ] ; then
	wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${WORDPRESS_DB_HOST}
	check
else
	echo -e "${OK} File wp-config.php already generated. Skipping."
fi


echo -e "${orange}[+] Creating administrator ${WORDPRESS_DB_ADMIN} and a sample wordpress site${clear}"
if ! wp core is-installed ; then
	wp core install --url="${DOMAIN_URL}" --title="Random Blog 42" --admin_user=${WORDPRESS_DB_ADMIN} --admin_password=${WORDPRESS_DB_ADMIN_PASSWORD} --admin_email="${WORDPRESS_DB_ADMIN}@42.fr" --skip-email
	check
else
	echo -e "${OK} Wordpress already installed. Skipping."
fi


echo -e "${orange}[+] Creating wordpress user: ${WORDPRESS_DB_USER}...${clear}"
if [[ $(wp user list --field=user_login | grep ${WORDPRESS_DB_USER} | wc -l) -eq 0 ]]; then
	wp user create ${WORDPRESS_DB_USER} "${WORDPRESS_DB_USER}@student.42.fr" --user_pass=${WORDPRESS_DB_USER_PASSWORD} --role=editor
	check
else
	echo -e "${OK} User ${WORDPRESS_DB_USER} already exists. Skipping."
fi


echo -e "${orange}[+] Cleaning sample post...${clear}"
if wp post exists 1 &> /dev/null ; then
	wp post delete 1 --force
	check;
else
	echo -e "${OK} Post already deleted. Skipping..."
fi


echo -e "${orange}[+] Generating some random posts...${clear}"
if ! wp post exists 4 &> /dev/null ; then
	wp post create --post_type=post --post_name='1st_post' --post_title='Un post inutile...' --post_content='Voici un post inutile pour tester la base de données...' --post_author=2 --post_status=publish
	check
else
	echo -e "${OK} 1st post already published. Skipping."
fi

if ! wp post exists 5 &> /dev/null ; then
	wp post create --post_type=post --post_name='2nd_post' --post_title='Un post très inutile !' --post_content='Voilà un post encore plus inutile !' --post_author=2 --post_status=publish
	check
else
	echo -e "${OK} 2nd post already published. Skipping."
fi


keep_alive

