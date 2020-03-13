SHELL := /bin/bash
# declaring variables
PROJECT_NAME ?= ansible-docker

# Compose file
COMPOSE_FILE := docker/docker-compose-v2.yml

.PHONY: build test clean prune

build:
	@echo '************ Building Skyfall RHN Server Services ************'
	@ docker-compose -f $(COMPOSE_FILE) build skyfall-RHN-server

	@echo '************  Pulling Latest Images ************'
	@ docker-compose -f $(COMPOSE_FILE) pull skyfall-ubt-1

	@echo '************ Building Skyfall RHN node services ************'
	@ docker-compose -f $(COMPOSE_FILE) build skyfall-rhn-1 skyfall-rhn-2

	@echo '************ Building Skyfall UBT node service ************'
	@ docker-compose -f $(COMPOSE_FILE) build skyfall-ubt-1
	@echo 'Build Complete ************'
	

test:
	@echo '************ Starting Services stacks ************'
	@ docker-compose up -d 
	@echo 'Start Complete ************'

clean:
	@echo '************ Clean service stack ************'
	@ docker-compose down --rmi all --remove-orphan 
	@echo 'Clean Complete ************'
	

prune:
	@echo '************ Destroy Everything ************'
	@ docker system prune -af
	@echo '************ Destroy Complete, Now Reclaim your Space !!! ************'



	
