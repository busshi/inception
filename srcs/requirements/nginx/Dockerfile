# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 14:01:35 by aldubar           #+#    #+#              #
#    Updated: 2021/05/02 23:39:37 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache nginx openssl curl

RUN		mkdir -p /run/nginx && chown nginx:nginx /run/nginx

COPY		conf/ /home/aldubar/nginx/

WORKDIR		/home/aldubar/nginx

EXPOSE		443
	
ENTRYPOINT 	["sh", "entry_point.sh"]
