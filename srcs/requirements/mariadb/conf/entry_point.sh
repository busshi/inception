#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"


keep_alive()
{
killall mariadbd
mariadbd
}


echo -e "${orange}[+] Starting mariadb demon...${clear}"
mariadbd &
[[ $? -eq 0 ]] && echo -e "${OK}" || echo -e "${KO}"


sleep 10

echo -e "${orange}[+] Checking mariadb configuration...${clear}"
file="/var/lib/mysql/config.txt"
[ -f "$file" ] && check_config=$( cat "$file" )
[ "$check_config" = "done" ] && { echo -e "${OK} Config already done. Skipping..."; keep_alive; } || echo -e "Need to create database..."


echo -e "${orange}[+] Creating database...${clear}"
mariadb -e "$(eval "echo \"$(cat create_db.sql)\"")"
[[ $? -eq 0 ]] && { echo -e "${OK}"; echo "done" > "$file"; keep_alive; } || { echo -e "${KO}"; echo "failed" > "$file"; }


