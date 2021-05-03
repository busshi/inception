# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 14:01:35 by aldubar           #+#    #+#              #
#    Updated: 2021/05/03 15:32:02 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache nginx openssl

RUN		mkdir -p /run/nginx && chown nginx:nginx /run/nginx

COPY		conf/ /home/nginx/

WORKDIR		/home/nginx

EXPOSE		443
	
ENTRYPOINT 	["sh", "entry_point.sh"]
