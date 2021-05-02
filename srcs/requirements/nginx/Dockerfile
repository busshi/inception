# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 14:01:35 by aldubar           #+#    #+#              #
#    Updated: 2021/05/02 22:23:00 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache nginx openssl

RUN		mkdir -p /home/aldubar/nginx

COPY		conf/ /home/aldubar/nginx/

WORKDIR		/home/aldubar/nginx

EXPOSE		443
	
ENTRYPOINT 	["sh", "entry_point.sh"]
