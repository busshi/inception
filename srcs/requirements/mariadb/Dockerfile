# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by aldubar           #+#    #+#              #
#    Updated: 2021/05/01 14:23:34 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13.4

RUN	apk add --no-cache mariadb  mariadb-client

COPY	conf/ /home/mysql

COPY	conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN	chown -R mysql:mysql /home/mysql && \
	mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && \
	mkdir -p /home/aldubar/data/mariadb && chown -R mysql:mysql /home/aldubar/data/mariadb && \
	mariadb-install-db --user=mysql --datadir='/home/aldubar/data/mariadb'


WORKDIR	/home/mysql

USER	mysql

EXPOSE	3306

ENTRYPOINT ["sh", "entry_point.sh"]
