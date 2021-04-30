#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"


keep_alive()
{
tail -f
}


echo -e "${orange}[+] Checking wordpress config${clear}"
file="/var/www/localhost/wordpress/config.txt"
[ -f "$file" ] && check_config=$( cat "$file" )
[ "$check_config" = "done" ] && { echo -e "${OK} Config already done! Skipping..."; keep_alive; } || echo "Need to configure wordpress..."


echo -e "${orange}[+] Configuring wordpress${clear}"
cp wp-config.php /var/www/localhost/wordpress/wp-config.php
[[ $? -eq 0 ]] && { echo -e "${OK} Config done${clear}"; echo "done" > "$file"; keep_alive; } || { echo -e "${KO} Config failed";  echo "failed" > "$file"; }


