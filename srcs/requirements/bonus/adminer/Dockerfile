# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 22:08:18 by aldubar           #+#    #+#              #
#    Updated: 2021/05/05 22:59:27 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache nginx php7-fpm php7-mysqli php7-session

WORKDIR		/home/adminer

RUN		wget -O index.php https://github.com/vrana/adminer/releases/download/v4.8.0/adminer-4.8.0-mysql.php && \
		wget https://raw.githubusercontent.com/pepa-linha/Adminer-Design-Dark/master/adminer.css

RUN		mkdir -p /run/nginx && chown nginx:nginx /run/nginx

COPY		conf/ /home/adminer

ENTRYPOINT	["sh", "entry_point.sh"]
