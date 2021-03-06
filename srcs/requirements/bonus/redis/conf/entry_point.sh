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


echo -e "${orange}[+] Configuring redis...${clear}"
file="/etc/redis.conf"
if [ $(cat "$file" | grep "maxmemory 256mb" | wc -l) -eq 0 ]; then
	sed -i "s/# maxmemory <bytes>/maxmemory 256mb/" "$file"
	sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/" "$file"
	sed -i "s/protected-mode yes/protected-mode no/g" "$file"
	sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" "$file"
	check
else
	echo -e "${OK} Redis already configured. Skipping."
fi


echo -e "${orange}[+] Starting redis server...${clear}"
redis-server /etc/redis.conf --daemonize yes --protected-mode no --maxmemory 256mb --maxmemory-policy allkeys-lru
check


echo -e "${orange}[+] Connecting to redis...${clear}"
ping=0
while [[ $ping -eq 0 ]] ; do
	[ "$(redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} ping 2> /dev/null)" != "PONG" ] && sleep 1 || ping=$(( $ping + 1 ))
done
echo -e "${OK}"


echo -e "${orange}[+] Starting redis monitor...${clear}"
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} monitor
