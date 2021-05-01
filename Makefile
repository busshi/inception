# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by aldubar           #+#    #+#              #
#    Updated: 2021/05/01 17:00:05 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include srcs/.env

CMD			= cd srcs && docker-compose

$(MARIADB_VOLUME):
			mkdir -p $(VOLUME_PATH)/mariadb

$(WORDPRESS_VOLUME):
			mkdir -p $(VOLUME_PATH)/wordpress

all:		build

build:		$(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
			@$(CMD) up -d
			@touch build

verbose:	$(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
			@$(CMD) up
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
			@docker rmi $$(docker image ls -q) --force
			@docker volume prune

re:		fclean all

help:
			@echo "Usage: make [build | start | stop | status \
			| restart | logs | clean | fclean | help]"

.PHONY: all, build, up, start, stop, status, restart, logs, clean, fclean, help
