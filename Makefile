SHELL:=/bin/bash

PSQL=docker-compose run database psql --host database --user postgres

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


test: ## Run the tests
	docker-compose run web_app rspec

repl: ## Run the interactive shell
	docker-compose run web_app \
		ruby ./bin/repl.rb

lint: ## Run the style linters
	docker-compose run web_app \
		rubocop \
		--display-cop-names \
		--extra-details \
		--display-style-guide

lint-fix: ## Automatically fix lint errors where possible
	docker-compose run web_app \
		rubocop --auto-correct

db-drop: ## Drop database
	$(PSQL) -c 'DROP DATABASE meet_dev'
	$(PSQL) -c 'DROP DATABASE meet_test'

db-create: ## Create database
	$(PSQL) -c 'CREATE DATABASE meet_dev'
	$(PSQL) -c 'CREATE DATABASE meet_test'

db-migrate: ## Migrate database
	docker-compose run web_app \
		sequel --echo \
		--migrate-directory db/migrations/ \
		postgres://postgres@database/meet_dev
	docker-compose run web_app \
		sequel --echo \
		--migrate-directory db/migrations/ \
		postgres://postgres@database/meet_test


# Inform Make of goals that are not files.
.PHONY: \
	help \
	test \
	lint \
	repl \
	lint-fix \
	db-create \
	db-drop \
	db-migrate
