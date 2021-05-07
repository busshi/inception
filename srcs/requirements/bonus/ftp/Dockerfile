# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/04 09:16:47 by aldubar           #+#    #+#              #
#    Updated: 2021/05/07 17:40:07 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache vsftpd

COPY		conf/	/entrypoint

WORKDIR		/entrypoint

EXPOSE		21

ENTRYPOINT	["sh", "entry_point.sh"]
