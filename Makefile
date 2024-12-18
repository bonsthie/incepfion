# ==================================================================================== #
# SETTING
# ==================================================================================== #

all: up

HOME := $(shell echo $$HOME)
export DATA_DIR=$(HOME)/data

PROJECT_NAME=incepfion

# Detect docker-compose or docker compose
DOCKER_COMPOSE_EXEC := $(shell command -v docker-compose 2>/dev/null)
DOCKER_COMPOSE_EXEC_ALT := $(shell command -v docker 2>/dev/null && docker --help | grep -q 'compose')

ifeq ($(DOCKER_COMPOSE_EXEC),)
    ifeq ($(DOCKER_COMPOSE_EXEC_ALT),)
        $(error Neither "docker-compose" nor "docker compose" found. Please install Docker Compose.)
    else
        DOCKER_COMPOSE_EXEC := docker compose
    endif
endif

DOCKER_COMPOSE_FILE=./src/docker-compose.yml
DOCKER_COMPOSE=$(DOCKER_COMPOSE_EXEC) -p $(PROJECT_NAME) -f $(DOCKER_COMPOSE_FILE)

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: Display this help message
.PHONY: help
help:
	@echo 'Available Commands:'
	@echo
	@grep -E '^##' $(MAKEFILE_LIST) | sed -E 's/^## //g' | column -t -s ':' | sed -e 's/^/ /'

# ==================================================================================== #
# DOCKER COMMANDS
# ==================================================================================== #

## up: Start Docker containers
.PHONY: up
up:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	@$(DOCKER_COMPOSE) up -d

## down: Stop and remove Docker containers
.PHONY: down
down:
	@$(DOCKER_COMPOSE) down -v

## start: Start stopped Docker containers
.PHONY: start
start:
	@$(DOCKER_COMPOSE) start

## stop: Stop running Docker containers
.PHONY: stop
stop:
	@$(DOCKER_COMPOSE) stop

## status: Show running Docker containers
.PHONY: status
status:
	@docker ps

## logs: Show Docker container logs
.PHONY: logs
logs:
	@$(DOCKER_COMPOSE) logs -f

## clean: Remove Docker containers and prune unused data
.PHONY: clean
clean:
	@$(DOCKER_COMPOSE) down --remove-orphans
	@docker system prune -af

## fclean: Remove Docker containers, volumes, network, and prune unused data
.PHONY: fclean
fclean:
	@$(DOCKER_COMPOSE) down -v --remove-orphans
	@docker system prune -af
	@rm -rf $(DATA_DIR)

## re: Restart all containers (stop, clean, up)
.PHONY: re
re: stop clean up
