# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 14:01:35 by aldubar           #+#    #+#              #
#    Updated: 2021/04/30 13:57:26 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13.4

RUN apk add --no-cache nginx openssl

COPY conf/ ./root/

WORKDIR /root/

EXPOSE 443

ENTRYPOINT ["sh", "entry_point.sh"]
