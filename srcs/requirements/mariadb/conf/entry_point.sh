#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"




echo -e "${orange}[+] Starting mariadb demon...${clear}"
mariadbd &
[[ $? -eq 0 ]] && echo -e "${OK}" || echo -e "${KO}"


sleep 10

echo -e "${orange}[+] Checking configuration...${clear}"
[ -f config.txt ] && check_config=$( cat config.txt )
[ "$check_config" = "done" ] && { echo -e "${OK} Config already done. Skipping..."; exit 0; } || echo -e "Need to create database..."


echo -e "${orange}[+] Creating database...${clear}"
mysql -u mysql < create_db.sql && echo "Config done" > config.txt
[[ $? -eq 0 ]] && { echo -e "${OK}"; echo "done" > config.txt; } || { echo -e "${KO}"; echo "failed" > config.txt; }




/bin/sh
