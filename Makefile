COMPOSE = docker-compose
COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_INIT = ./srcs/init.sh
ENV_FILE = ./srcs/.env
SECRETS = ./secrets

# colours
RED = \033[1;31m
GREEN = \033[1;32m
BROWN = \033[1;33m
END = \033[0m

all: up

up:
		@echo "$(BROWN)[ starting containers ]$(END)"
		@$(DOCKER_INIT)
		@$(COMPOSE) -f $(COMPOSE_FILE) up --build --force-recreate -d

down:
		@echo "$(BROWN)[ stopping and removing containers... ]$(END)"
		@$(COMPOSE) -f $(COMPOSE_FILE) down

clean: down
		@echo "$(BROWN)[ removing images... ]$(END)"
		@docker builder prune -a -f
		@docker system prune -f

fclean: clean
		@echo "$(BROWN)[ removing volumes... ]$(END)"
		@docker system prune --volumes -af
		@echo "$(BROWN)[ removing top secrets... ]$(END)"
		@rm -rf ~/data
		@rm -rf $(SECRETS) $(ENV_FILE)

re: down up