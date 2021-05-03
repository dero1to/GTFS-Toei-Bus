APP = python3

build:
	docker-compose build
.PHONY: build

up:
	docker-compose up -d
.PHONY: up

down:
	docker-compose down
.PHONY: down

exec:
	docker-compose exec $(APP) bash
.PHONY: exec

gtfs:
	python3 main.py
