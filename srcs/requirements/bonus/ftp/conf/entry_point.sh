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
sed -i "s/FTP_USER/${FTP_USER}/g" "$conf"
path=$(echo ${FTP_PATH} | sed 's_/_\\/_g')
sed -i "s/FTP_PATH/${path}/g" "$conf"
cert=$(echo ${CERT_KEY} | sed 's_/_\\/_g')
sed -i "s/CERT_KEY/${cert}/g" "$conf"
cp "$conf" /etc/vsftpd
check
user="vsftpd.user_list"
if [ -f "$user" ] ; then
	echo -e "${orange}[+] Adding user ${FTP_USER}...${clear}"
	{ echo "$FTP_PASSWORD"; echo "$FTP_PASSWORD"; } | adduser ${FTP_USER}
	check
	echo -e "${orange}[+] Authorizing user ${FTP_USER}...${clear}"
	sed -i "s/FTP_USER/${FTP_USER}/g" "$user"
	mv "$user" /etc/vsftpd/
	check
fi


if [ ! -f ${CERT_KEY} ] ; then
	echo -e "${orange}[+] Waiting for self certificat to be generated by nginx container...${clear}"
	while [ ! -f ${CERT_KEY} ]; do
		sleep 1
	done
	echo -e "${OK} Certificat generated. Continue now."
fi


echo -e "${orange}[+] Launching vspftp server...${clear}"
vsftpd /etc/vsftpd/vsftpd.conf
