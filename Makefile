SHELL:=/bin/bash

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


start: ## Run the app
	bundle exec rackup


test: ## Run the tests
	bundle exec rspec


lint: ## Run the style linters
	bundle exec rubocop --display-cop-names --extra-details --display-style-guide

lint-fix: ## Automatically fix lint errors where possible
	bundle exec rubocop --auto-correct


.PHONY: \
	help \
	start \
	test \
	lint \
	lint-fix
