# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/04 09:16:47 by aldubar           #+#    #+#              #
#    Updated: 2021/05/04 15:32:10 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN		apk add vsftpd

COPY		conf/	/home/ftp

WORKDIR		/home/ftp

EXPOSE		21

ENTRYPOINT	["sh", "entry_point.sh"]
