# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 22:08:18 by aldubar           #+#    #+#              #
#    Updated: 2021/05/07 17:44:59 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache nginx php7-fpm

RUN		mkdir -p /run/nginx && chown nginx:nginx /run/nginx

COPY		conf/www/ /home/website

COPY		conf/entry_point.sh conf/default.conf conf/www.conf /entrypoint/

WORKDIR		/entrypoint

EXPOSE		9999

ENTRYPOINT	["sh", "entry_point.sh"]
