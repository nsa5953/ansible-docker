# Author: Nilesh Attarde
# Build script to create, remove, clean, rebuild docker multiple containers and its associtated images
# Shell Functions
SHELL := /bin/bash
YELLOW := "\e[1;33m"
NC := "\e[0m"

INFO := @bash -c '\
  printf $(YELLOW); \
  echo "=> $$1"; \
  printf $(NC)' SOME_VALUE

# declaring variables
PROJECT_NAME ?= ansible-docker

# Compose file
COMPOSE_FILE := -f docker-compose-v2.yml

# Spcifiy makefile targets
.PHONY: build start clean prune

# Target functions: 
build:
	${INFO} "Building Skyfall RHN Server Services ....."
	@ docker-compose $(COMPOSE_FILE) build skyfall-RHN-server

	${INFO} "Pulling Latest Images ....."
	@ docker-compose $(COMPOSE_FILE) pull skyfall-ubt-1

	${INFO} "Building Skyfall RHN node services ....."
	@ docker-compose $(COMPOSE_FILE) build skyfall-rhn-1 skyfall-rhn-2

	${INFO} "Building Skyfall UBT node service ....."
	@ docker-compose $(COMPOSE_FILE) build skyfall-ubt-1
	${INFO} "Build Complete ....."
	
start:
	${INFO} "Starting Services stacks ....."
	@ docker-compose $(COMPOSE_FILE) up -d 
	${INFO} "Start Complete ....."

clean:
	${INFO} "Clean service stack ....."
	@ docker-compose $(COMPOSE_FILE) down 
	${INFO} "Clean Complete ....."
	
cleanall:
	${INFO} "Clean service stack ....."
	@ docker-compose $(COMPOSE_FILE) down --rmi all --remove-orphan 
	${INFO} "Clean Complete ....."

prune:
	${INFO} "Destroy Everything ....."
	@ docker system prune -af
	${INFO} "Destroy Complete, Reclaim your Space Now :) !!! .........."

rebuild:
	${INFO} "Rebuild process ==> Clean, build and start"
	@make -s clean
	@make -s build
	@make -s start

check:
	${INFO} "Check docker-compose stack ....."
	@ docker-compose $(COMPOSE_FILE) ps -a


	
