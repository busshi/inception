# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 14:23:37 by aldubar           #+#    #+#              #
#    Updated: 2021/05/08 16:27:27 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache redis

COPY		conf/ /entrypoint

WORKDIR		/entrypoint

ENTRYPOINT	["sh", "entry_point.sh"]
