# Usage: make <command> <exercise>
#   make test lasagna
#   make lint hello-world
#   make watch annalyns-infiltration
#   make install lasagna
#   make list

.DEFAULT_GOAL := help

COMMANDS := test lint watch install format
EXERCISES := $(patsubst %/package.json,%,$(wildcard */package.json))

# Capture `make test lasagna` → COMMAND=test, EXERCISE=lasagna
COMMAND := $(firstword $(MAKECMDGOALS))
EXERCISE := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

# Swallow the exercise name so make does not try to build it as a target
ifneq ($(filter $(COMMAND),$(COMMANDS)),)
  ifneq ($(EXERCISE),)
    $(eval $(EXERCISE):;@:)
  endif
endif

.PHONY: help list test lint watch install format $(EXERCISES)

help:
	@echo "Exercism JavaScript helpers"
	@echo ""
	@echo "  make test <exercise>     Run tests"
	@echo "  make lint <exercise>     Run ESLint"
	@echo "  make watch <exercise>    Run tests in watch mode"
	@echo "  make install <exercise>  Install dependencies"
	@echo "  make format <exercise>   Format sources"
	@echo "  make list                List downloaded exercises"
	@echo ""
	@echo "Exercises: $(EXERCISES)"

list:
	@printf '%s\n' $(EXERCISES)

define require_exercise
	@if [ -z "$(EXERCISE)" ]; then \
		echo "Usage: make $(COMMAND) <exercise>"; \
		echo "Exercises: $(EXERCISES)"; \
		exit 1; \
	fi
	@if [ ! -d "$(EXERCISE)" ] || [ ! -f "$(EXERCISE)/package.json" ]; then \
		echo "Unknown exercise: $(EXERCISE)"; \
		echo "Exercises: $(EXERCISES)"; \
		exit 1; \
	fi
endef

define ensure_deps
	@if [ ! -d "$(EXERCISE)/node_modules" ]; then \
		echo "Installing dependencies for $(EXERCISE)..."; \
		pnpm --dir "$(EXERCISE)" install; \
	fi
endef

test:
	$(require_exercise)
	$(ensure_deps)
	pnpm --dir "$(EXERCISE)" test

lint:
	$(require_exercise)
	$(ensure_deps)
	pnpm --dir "$(EXERCISE)" lint

watch:
	$(require_exercise)
	$(ensure_deps)
	pnpm --dir "$(EXERCISE)" watch

install:
	$(require_exercise)
	pnpm --dir "$(EXERCISE)" install

format:
	$(require_exercise)
	$(ensure_deps)
	pnpm --dir "$(EXERCISE)" format
