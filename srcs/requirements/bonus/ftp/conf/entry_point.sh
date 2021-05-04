#!/bin/sh

orange="\033[0;33m"
green="\033[0;32m"
red="\033[0;31m"
clear="\033[0m"

OK="[ ${green}OK${clear} ]"
KO="[ ${red}KO${clear} ]"


check()
{
[[ $? -eq 0 ]] && echo -e "$OK" || echo -e "$KO"
}



echo -e "${orange}[+] Configuring vsftpd server...${clear}"
conf="vsftpd.conf"
if [ -f "$conf" ] ; then
	sed -i "s/FTP_USER/${FTP_USER}/g" "$conf"
	path=$(echo ${FTP_VOLUME_PATH} | sed 's_/_\\/_g')
	sed -i "s/FTP_VOLUME_PATH/${path}/g" "$conf"
	mv "$conf" /etc/vsftpd
	check
	echo -e "${orange}[+] Adding user {FTP_USER}...${clear}"
	{ echo "$FTP_PASSWORD"; echo "$FTP_PASSWORD"; } | adduser ${FTP_USER}
	check
	user="vsftpd.user_list"
	if [ -f "$user" ] ; then
		echo -e "${orange} Authorizing user ${FTP_USER}...${clear}"
		sed -i "s/FTP_USER/${FTP_USER}/g" "$user"
		mv "$user" /etc/vsftpd/
		check
	fi
	echo -e "${orange}[+] Creating symlink for default directory...${clear}"
	ln -s /var/lib/ftp "${FTP_VOLUME_PATH}/${FTP_USER}"
	check
else
	echo "Vsftpd already configured. Skipping."
fi


echo -e "${orange}[+] Launching vspftp server...${clear}"
vsftpd /etc/vsftpd/vsftpd.conf
