#!/bin/bash

source srcs/.env


build()
{
if [[ $(cat /etc/hosts | grep "127.0.0.1 ${DOMAIN_URL}" | wc -l) -eq 0 ]] ; then
	echo "127.0.0.1 ${DOMAIN_URL}" | sudo tee -a /etc/hosts
fi

for dir in ${MARIADB_VOLUME_PATH} ${WORDPRESS_VOLUME_PATH}; do
	[ ! -d ${dir} ] && sudo mkdir -p ${dir}
done
}


clean()
{
if [[ $(cat /etc/hosts | grep "127.0.0.1 ${DOMAIN_URL}" | wc -l) -gt 0 ]] ; then
	sudo sed -i "/127.0.0.1 $DOMAIN_URL/d" /etc/hosts
fi

for dir in ${MARIADB_VOLUME_PATH} ${WORDPRESS_VOLUME_PATH}; do
        [ -d ${dir} ] && sudo rm -rf ${dir}
done
}


case "$1" in
	"build"|"clean")
		"$1"
		;;
	*)
		echo "Usage: ./prepare.sh [build|clean]"
		;;
esac

exit 0
