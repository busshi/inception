# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/04 09:16:47 by aldubar           #+#    #+#              #
#    Updated: 2021/05/04 17:17:23 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add --no-cache vsftpd openssl

COPY		conf/	/home/ftp

WORKDIR		/home/ftp

EXPOSE		21

ENTRYPOINT	["sh", "entry_point.sh"]
