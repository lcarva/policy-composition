all: generate

generate: $(shell find src -type f)
	@./scripts/generate.sh

