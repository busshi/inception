#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"


echo -e "${orange}[+] Checking wordpress config${clear}"
[ -f config.txt ] && check_config=$( cat config.xt )
[ "$check_config" = "done" ] && { echo -e "${OK}Config already done! Skipping..."; exit 0; } || echo "Need to configure wordpress..."


echo -e "${orange}[+] Configuring wordpress${clear}"
cp wp-config.php /wordpress/wp-config.php
[[ $? -eq 0 ]] && { echo -e "${OK} Config done${clear}"; echo "done" > config.txt; } || { echo -e "${KO} Config failed";  echo "failed" > config.txt; }


exit 0
