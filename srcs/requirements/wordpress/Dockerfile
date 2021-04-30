# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by aldubar           #+#    #+#              #
#    Updated: 2021/04/30 17:19:47 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:3.13.4

RUN	apk add --no-cache php php-fpm 

RUN	mkdir -p /home/aldubar/data && cd /home/aldubar/data && \
	wget -O wordpress.tar.gz https://fr.wordpress.org/wordpress-5.7.1-fr_FR.tar.gz && \
	tar -xf wordpress.tar.gz && \
	rm -f wordpress.tar.gz


COPY	conf/ /root

WORKDIR		/root

ENTRYPOINT	["sh", "entry_point.sh"]
