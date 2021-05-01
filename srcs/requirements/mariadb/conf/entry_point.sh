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
start_daemon
}


echo -e "${orange}[+] Starting mariadb...${clear}"
start_daemon &
[[ $? -eq 0 ]] && echo -e "${OK}" || echo -e "${KO}"


sleep 10

echo -e "${orange}[+] Checking mariadb configuration...${clear}"
file="/home/aldubar/data/mariadb/config.txt"
[ -f "$file" ] && check_config=$( cat "$file" )
[ "$check_config" = "done" ] && { echo -e "${OK} Config already done. Skipping..."; keep_alive; } || echo -e "Need to create database..."



echo -e "${orange}[+] Creating mariadb database...${clear}"
cd /home/mysql; mariadb -e "$(eval "echo \"$(cat create_db.sql)\"")"
[[ $? -eq 0 ]] && { echo -e "${OK}"; echo "done" > "$file"; keep_alive; } || { echo -e "${KO}"; echo "failed" > "$file"; }


