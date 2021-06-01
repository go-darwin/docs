all: embedmd

TEMPLATE := $(wildcard **/embedmd/*.md)

##@ markdown

.PHONY: embedmd
embedmd: ${TEMPLATE}
	@rm -f $(subst embedmd/,,$(patsubst %.embedmd.md,%.md,${TEMPLATE}))
	embedmd $+ > $(subst embedmd/,,$(patsubst %.embedmd.md,%.md,${TEMPLATE}))

##@ help

.PHONY: help
help:  ## Show make target help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[33m<target>\033[0m\n"} /^[a-zA-Z_0-9\/%_-]+:.*?##/ { printf "  \033[32m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: env/%
env/%:  ## Print the value of MAKEFILE_VARIABLE. Use `make env/COMMANDS`, `make env/IMAGE` or etc.
	@echo $($*)
