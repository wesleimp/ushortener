## build: Build all defined containers
.PHONY: build
build:
	@docker-compose build

## up: Up all containers
.PHONY: up
up:
	@docker-compose up

## setup: Install dependencies, create a database and execute migrations
.PHONY: setup
setup:
	./docker-run "mix do deps.get, ecto.create, ecto.migrate"
	@echo
	./docker-run "cd ./apps/ushortener_web && npm install --prefix assets"

## run: Run application
.PHONY: run
run:
	@docker-compose up app

## setup-test: Install dependencies, create a database test and execute migrations using testing config
.PHONY: setup-test
setup-test:
	./docker-run "MIX_ENV=test mix do deps.get, ecto.create, ecto.migrate"

## test: Run all tests
.PHONY: test
test:
	./docker-run "MIX_ENV=test mix test"

## help: Show all available commands
help: Makefile
	@echo
	@echo " Choose a command run:"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo