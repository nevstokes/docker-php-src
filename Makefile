DOCKER_REPO = nevstokes/php-src

export

.DEFAULT_GOAL := help

.PHONY: build help pre-build

help: ## Displays list and descriptions of available targets
	@awk -F ':|\#\#' '/^[^\t].+:.*\#\#/ {printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST) | sort

pre-build: ## Create Docker image with dependencies for fetching source
	@./hooks/pre_build

build: pre-build ## Build the Docker image
	@./hooks/build
