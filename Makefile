# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aldubar <aldubar@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/29 13:58:41 by aldubar           #+#    #+#              #
#    Updated: 2021/05/04 09:24:47 by aldubar          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include srcs/.env

CMD			= cd srcs && docker-compose

all:		build

build:
			@sudo mkdir -p $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH) $(FTP_VOLUME_PATH)
			@echo "127.0.0.1 $(DOMAIN_URL)" | sudo tee -a /etc/hosts
			@$(CMD) up --build -d
			@touch build

verbose:
			@sudo mkdir -p $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH) $(FTP_VOLUME_PATH)
			@echo "127.0.0.1 $(DOMAIN_URL)" | sudo tee -a /etc/hosts
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
			@docker volume prune --force
			@sudo rm -rf $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH) $(FTP_VOLUME_PATH)
			@sudo sed -i "s/127.0.0.1 $(DOMAIN_URL)//g" /etc/hosts

rmi:		prune
			@if [ $$(docker image ls -q | wc -l) -ge 1 ]; then docker rmi $$(docker image ls -q) --force; fi

re:		fclean all

help:
			@echo "Usage: make [build | start | stop | status | restart | logs | clean | fclean | help]"

.PHONY: all, build, up, start, stop, status, restart, logs, clean, fclean, help
