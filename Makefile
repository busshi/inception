# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by aldubar           #+#    #+#              #
#    Updated: 2021/04/30 15:33:39 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

YAML		= srcs/docker-compose.yaml

CMD		= cd srcs && docker-compose


all:	build up

build:
	@$(CMD) build

up:
	@$(CMD) up

start:
	@$(CMD) start

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

prune:	clean
	@docker rmi $$(docker image ls -q) --force
	@docker volume prune

re:	fclean all

help:
	@echo "Usage: make [up | start | stop | status | restart | logs | clean | fclean | help]"

.PHONY: all, build, up, start, stop, status, restart, logs, clean, fclean, help
