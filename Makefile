all: up

up:
	@mkdir -p /home/babonnet/data/mariadb
	@mkdir -p /home/babonnet/data/wordpress
	@docker-compose -f ./src/docker-compose.yml up -d

down:
	@docker-compose -f ./src/docker-compose.yml down -v

start:
	@docker-compose -f ./src/docker-compose.yml start

stop:
	@docker-compose -f ./src/docker-compose.yml stop

status:
	@docker ps
fclean :
		@rm -rf /home/babonnet/data/
		@docker network remove incepfion
		@docker volume rm wordpress mariadb
		@docker system prune -af

re: stop fclean all
