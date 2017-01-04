SHELL:=/bin/bash

PSQL=docker-compose run database psql --host database --user postgres

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

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


#
# Dev & test database management
#

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


#
# Infrastructure provisioning and management
#

terraform-plan: .terraform/terraform.tfstate ## Dry-run of infrastruture changes for dev env
	terraform plan -var-file=infrastruture/dev.tfvars infrastruture

terraform-apply: .terraform/terraform.tfstate ## Apply infrastruture changes for dev env
	terraform apply -var-file=infrastruture/dev.tfvars infrastruture

terraform-destroy: .terraform/terraform.tfstate
	terraform destroy -var-file=infrastruture/dev.tfvars infrastruture

.terraform/terraform.tfstate:
	terraform remote config \
		-backend=s3 \
		-backend-config="bucket=meet-app--terraform-state" \
		-backend-config="key=meet-app--dev.tfstate" \
		-backend-config="region=eu-west-2"

# Inform Make of goals that are not files.
.PHONY: \
	help \
	test \
	lint \
	repl \
	lint-fix \
	db-create \
	db-drop \
	db-migrate \
	terraform-plan \
	terraform-apply \
	terraform-destroy
