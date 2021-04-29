#!/bin/sh

red="\033[0;31m"
green="\033[0;32m"
clear="\033[0;m"


### Setting up nginx
openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=FRANCE/L=Paris/O=42fr/OU=42fr/CN=aldubar" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
cp localhost /etc/nginx/http.d/default.conf && rm -f localhost
#ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
nginx -t
[[ $? -eq 0 ]] && str="${green}ok" || str="${red}ko"
echo -e "[ ${str}${clear} ] Configuring nginx"

/bin/sh

exit 0
