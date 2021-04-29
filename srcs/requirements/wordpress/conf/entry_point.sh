#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"


echo -e "${orange}[+] Checking wordpress config${clear}"
file="/inception/wordpress/config.txt"
[ -f "$file" ] && check_config=$( cat "$file" )
[ "$check_config" = "done" ] && { echo -e "${OK}Config already done! Skipping..."; exit 0; } || echo "Need to configure wordpress..."


echo -e "${orange}[+] Configuring wordpress${clear}"
cp wp-config.php /wordpress/wp-config.php
[[ $? -eq 0 ]] && { echo -e "${OK} Config done${clear}"; echo "done" > "$file"; } || { echo -e "${KO} Config failed";  echo "failed" > "$file"; }


exit 0
