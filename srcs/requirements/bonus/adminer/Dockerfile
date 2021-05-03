# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/03 22:08:18 by aldubar           #+#    #+#              #
#    Updated: 2021/05/03 22:50:37 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

WORKDIR		/home/adminer

RUN		wget -O adminer.php https://github.com/vrana/adminer/releases/download/v4.8.0/adminer-4.8.0.php && \
		wget https://raw.githubusercontent.com/pepa-linha/Adminer-Design-Dark/master/adminer.css

COPY		conf/ /home/adminer

ENTRYPOINT	["sh", "entry_point.sh"]
