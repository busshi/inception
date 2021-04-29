# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: busshi <aldubar@student.42.fr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 15:58:47 by busshi            #+#    #+#              #
#    Updated: 2021/04/29 16:08:34 by busshi           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13.4

RUN apk add --no-cache php php-fpm 

COPY conf/ ./root/

WORKDIR /root/

ENTRYPOINT ["sh", "entry_point.sh"]
