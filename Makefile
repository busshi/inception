# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: busshi <aldubar@student.42.fr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by busshi            #+#    #+#              #
#    Updated: 2021/04/29 17:06:35 by busshi           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

YAML	= srcs/docker-compose.yaml

CMD	= docker-compose -f $(YAML)


up:
	@$(CMD) up

start:
	@$(CMD) up -d

stop:
	@$(CMD) stop

status:
	@$(CMD) ps

restart: stop start

logs:
	@$(CMD) logs --tail=100 -f

clean:
	@$(CMD) down

fclean: clean
	@img=$(docker image ls -q)
	@if [ -n "${img}" ]; then docker rmi -f $(img) --force; fi

re:	fclean up

help:
	@echo "Usage: make [up | start | stop | status | restart | logs | clean | fclean | help]"

.PHONY: up, start, stop, status, restart, logs, clean, fclean, help
