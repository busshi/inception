# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by aldubar           #+#    #+#              #
#    Updated: 2021/05/05 00:34:58 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache php7 php7-fpm php7-phar php7-json php7-curl \
		php7-mysqli mariadb-client php7-iconv php7-redis

RUN		mkdir -p /home/aldubar/data/wordpress && cd /home/aldubar/data/wordpress && \
		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp && \
		wp core download --locale=fr_FR

COPY		conf/ /home/aldubar/data/wordpress/

WORKDIR		/home/aldubar/data/wordpress

EXPOSE		9000

ENTRYPOINT	["sh", "entry_point.sh"]
