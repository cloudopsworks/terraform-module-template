SHELL := /bin/bash
TRONADOR_AUTO_INIT := true
define PROVIDER_CHOMP
provider "aws" {
  alias = "default"
}
provider "aws" {
  alias = "account"
}
endef
export PROVIDER_CHOMP
VER_NUM := $(shell cat .github/_VERSION)
VER_MAJOR := $(shell echo $(VER_NUM) | cut -f1 -d.)
VER_MINOR := $(shell echo $(VER_NUM) | cut -f2 -d.)
VER_PATCH := $(shell echo $(VER_NUM) | cut -f3 -d.)

# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md docs/terraform.md

-include $(shell curl -sSL -o .tronador "https://cowk.io/acc"; echo .tronador)

temp_provider:
	echo "$$PROVIDER_CHOMP" > provider.temp.tf

## Lint terraform code
lint: temp_provider
	$(SELF) tofu/install tofu/get-modules tofu/get-plugins tofu/lint tofu/validate

.PHONY: tag
.PHONY: tag_local
.PHONY: version

co_master:
	git checkout master

tag_local: co_master
	git tag -f $(VER_MAJOR).$(VER_MINOR)
	git tag -f $(VER_MAJOR)

## Tag the current version
tag: tag_local
	git push origin -f $(VER_MAJOR).$(VER_MINOR)
	git push origin -f $(VER_MAJOR)
	git switch -

## Update generate the version
version: gitflow/version/file
