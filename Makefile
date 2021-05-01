# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by aldubar           #+#    #+#              #
#    Updated: 2021/05/01 17:08:16 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include srcs/.env

CMD			= cd srcs && docker-compose

$(VOLUMES):
			mkdir -p $(MARIADB_VOLUME_PATH) \
			mkdir -p $(WORDPRESS_VOLUME_PATH)

all:		build

build:		$(VOLUMES)
			@$(CMD) up -d
			@touch build

verbose:	$(VOLUMES)
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
