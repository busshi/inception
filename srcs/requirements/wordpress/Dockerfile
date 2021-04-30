# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by aldubar           #+#    #+#              #
#    Updated: 2021/04/30 15:29:14 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:3.13.4

RUN	apk add --no-cache php php-fpm 

RUN	mkdir -p /var/www/localhost && cd /var/www/localhost && \
	wget http://fr.wordpress.org/latest-fr_FR.tar.gz && \
	tar -xf latest-fr_FR.tar.gz && \
	rm -f latest-fr_FR.tar.gz


COPY	conf/ root/

WORKDIR		/root

ENTRYPOINT	["sh", "entry_point.sh"]
