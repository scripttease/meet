SHELL:=/bin/bash

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


test: ## Run the tests
	docker-compose run web_app \
		rspec

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
	docker-compose run database \
		psql \
		--host database \
		--user postgres \
		-c 'DROP DATABASE meet_dev'

db-create: ## Create database
	docker-compose run database \
		psql \
		--host database \
		--user postgres \
		-c 'CREATE DATABASE meet_dev'

db-migrate: ## Migrate database
	docker-compose run web_app \
		sequel --echo \
		--migrate-directory db/migrations/ \
		postgres://postgres@database/meet_dev


# Inform Make of goals that are not files.
.PHONY: \
	help \
	test \
	lint \
	lint-fix \
	db-create \
	db-drop \
	db-migrate
