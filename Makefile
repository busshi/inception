# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by aldubar           #+#    #+#              #
#    Updated: 2021/05/05 16:14:16 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include srcs/.env

CMD			= cd srcs && docker-compose

SCRIPT			= /bin/bash srcs/requirements/tools/make.sh

all:		build

build:
			@$(SCRIPT) build
			@$(CMD) up --build -d
			@touch build

verbose:
			@$(SCRIPT) build
			@$(CMD) up --build
			@touch build

start:
			@$(CMD) start

stop:
			@$(CMD) stop

status:
			@$(CMD) ps

restart:	stop start

logs:
			@$(CMD) logs --tail=100 -f

clean:
			@$(CMD) down
			@rm -f build

fclean:		clean
			@$(CMD) down -v

prune:		fclean
			@docker system prune --volumes --all --force
			@$(SCRIPT) clean

re:		fclean all

help:
			@echo "Usage: make [build | start | stop | status | restart | logs | clean | fclean | help]"

.PHONY: all, build, verbose, start, stop, status, restart, logs, clean, fclean, prune, help
