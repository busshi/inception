# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: busshi <aldubar@student.42.fr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by busshi            #+#    #+#              #
#    Updated: 2021/04/30 11:19:09 by busshi           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:3.13.4

RUN	apk add --no-cache mariadb  mariadb-client

COPY	conf/ /home/mysql

RUN	chown -R mysql:mysql /home/mysql && \
	mkdir -p /run/mysqld && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql && \
	mariadb-install-db --user=mysql --datadir='/var/lib/mysql'

WORKDIR	/home/mysql

USER	mysql

EXPOSE	3306

ENTRYPOINT ["sh", "entry_point.sh"]
