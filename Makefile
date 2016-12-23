SHELL:=/bin/bash

IN_DOCKER=docker-compose run web_app

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


start: ## Run the app and deps with docker
	@echo ""
	@cat docs/meet.txt
	@echo ""
	docker-compose up


# See ./.rspec and ./spec_helper.rb for additional test configuration
test: ## Run the tests
	time $(IN_DOCKER) bundle exec rspec


lint: ## Run the style linters
	$(IN_DOCKER) bundle exec rubocop --display-cop-names --extra-details --display-style-guide

lint-fix: ## Automatically fix lint errors where possible
	$(IN_DOCKER) docker-compose run web_app bundle exec rubocop --auto-correct


.PHONY: \
	help \
	start \
	test \
	lint \
	lint-fix
