# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by aldubar           #+#    #+#              #
#    Updated: 2021/05/08 16:26:44 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM 		alpine:3.13.4

RUN		apk add --no-cache mariadb  mariadb-client

COPY		conf/ /entrypoint/

COPY		conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN		mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && \
		mkdir -p /home/mariadb && chown -R mysql:mysql /home/mariadb && \
		mariadb-install-db --user=mysql --datadir='/home/mariadb'


WORKDIR		/entrypoint

ENTRYPOINT ["sh", "entry_point.sh"]
