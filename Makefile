IMAGE_NAME = nevstokes/php-src

export

.DEFAULT_GOAL := help
.PHONY: build help

build: Dockerfile hooks/build ## Build the Docker image
	@./hooks/build

help: ## Display list and descriptions of available targets
	@awk -F ':|\#\#' '/^[^\t].+:.*\#\#/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST) | sort
