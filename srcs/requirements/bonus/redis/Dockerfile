# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 14:23:37 by aldubar           #+#    #+#              #
#    Updated: 2021/05/03 16:40:04 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache redis

COPY		conf/ /home/redis/

WORKDIR		/home/redis

ENTRYPOINT	["sh", "entry_point.sh"]
