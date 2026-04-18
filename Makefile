all:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
	@docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

clean:
	@docker compose -f ./srcs/docker-compose.yml down -v

fclean: clean
	@docker system prune -af
	@sudo rm -rf /home/$(USER)/data

re: fclean all

.PHONY: all up down stop clean fclean re
