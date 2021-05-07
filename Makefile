# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by aldubar           #+#    #+#              #
#    Updated: 2021/05/08 01:00:35 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include srcs/.env

CMD			= cd srcs && docker-compose

SCRIPT			= /bin/bash srcs/requirements/tools/make.sh

all:
			@$(SCRIPT) build
			@$(CMD) up --build -d

verbose:
			@$(SCRIPT) build
			@$(CMD) up --build

start:
			@$(CMD) start

stop:
			@$(CMD) stop

status:
			@$(CMD) ps

restart:	stop start

log:
			@$(CMD) logs --tail=100 -f

clean:
			@$(CMD) down

fclean:		clean
			@$(CMD) down -v
			@docker system prune --volumes --all --force
			@$(SCRIPT) clean

re:		fclean all

help:
			@echo "Usage: make [verbose | start | stop | status | restart | log | clean | fclean | re | help]"

.PHONY: all, verbose, start, stop, status, restart, log, clean, fclean, re, help
