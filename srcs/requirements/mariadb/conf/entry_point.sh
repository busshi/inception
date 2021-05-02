#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"



start_daemon()
{
cd '/usr' ; /usr/bin/mysqld_safe --datadir='/home/aldubar/data/mariadb'
}


keep_alive()
{
killall mariadbd
sleep 5
echo -e "${orange}[+] Restarting mariadb...${clear}"
start_daemon
}


echo -e "${orange}[+] Starting mariadb...${clear}"
start_daemon &
[[ $? -eq 0 ]] && echo -e "${OK}" || echo -e "${KO}"


sleep 10

echo -e "${orange}[+] Checking mariadb configuration...${clear}"

check=$( mariadb -e "SHOW DATABASES" | grep ${MYSQL_DATABASE} | wc -l )
if [[ $check -eq 1 ]] ; then
	echo -e "${OK}"
	keep_alive
else
	echo -e "${orange}[+] Creating mariadb database...${clear}"
	cd /home/mysql; mariadb -e "$(eval "echo \"$(cat create_db.sql)\"")"
	[[ $? -eq 0 ]] && { echo -e "${OK}"; keep_alive; } || { echo -e "${KO}"; exit 1; }
fi

