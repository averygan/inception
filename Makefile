# define makefile variables

COMPOSE = docker-compose
COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_INIT = ./srcs/init.sh
ENV_FILE = ./srcs/.env
SECRETS = ./secrets

#------------------------------------------------------------------------

# colours

RED = \033[1;31m
GREEN = \033[1;32m
BROWN = \033[1;33m
END = \033[0m

#------------------------------------------------------------------------

# RULES

all: up

# ensure docker is installed and all required files/directories exist
# create and start all containers in the docker compose file
# --build: build images before starting
# -d: run detached in background
up:
		@echo "$(BROWN)[ Checking prerequisites... ]$(END)"
		@$(DOCKER_INIT)
		@$(COMPOSE) -f $(COMPOSE_FILE) up --build --force-recreate -d

down:
		@echo "$(BROWN)[ Stopping and removing containers... ]$(END)"
		@$(COMPOSE) -f $(COMPOSE_FILE) down

clean: down
		@echo "$(BROWN)[ Removing build cache... ]$(END)"
		@docker builder prune -a -f
		@docker system prune -f

fclean: clean
		@echo "$(BROWN)[ Removing volumes... ]$(END)"
		@docker system prune --volumes -af
		@echo "$(BROWN)[ Removing data and secrets... ]$(END)"
		@rm -rf ~/data
		@rm -rf $(SECRETS) $(ENV_FILE)

re: down up