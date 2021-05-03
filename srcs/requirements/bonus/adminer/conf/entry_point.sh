#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"

DIR=${WORDPRESS_VOLUME_PATH}


check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || echo -e "$KO"
}



echo -e "${orange}[+] Copying adminer files...${clear}"
for file in "adminer.php" "adminer.css" ; do
	if [ -f "$file" ] ; then
		mv "$file" "$DIR/"
		check
	else
		echo -e "${OK} File ${file} for adminer already copied. Skipping."
	fi
done


tail -f


