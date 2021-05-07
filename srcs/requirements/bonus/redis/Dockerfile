# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 14:23:37 by aldubar           #+#    #+#              #
#    Updated: 2021/05/07 17:41:10 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache redis

COPY		conf/ /entrypoint

WORKDIR		/entrypoint

EXPOSE		6379

ENTRYPOINT	["sh", "entry_point.sh"]
