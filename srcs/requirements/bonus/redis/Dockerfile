# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 14:23:37 by aldubar           #+#    #+#              #
#    Updated: 2021/05/05 00:53:28 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache redis

COPY		conf/ /home/redis/

WORKDIR		/home/redis

EXPOSE		6379

ENTRYPOINT	["sh", "entry_point.sh"]
