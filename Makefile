PLATFORMS ?= linux/amd64,linux/arm64
TAG = latest

# We need buildx to have multi-platforms build on the CI
DOCKER_BUILD ?= docker buildx build

.PHONY: help
	
help:
	@echo "Check Makefile for options"
	
login:
	docker login
	
# Leave this at the end!
include makefiles/cpp-dev.mk
include makefiles/mpi-dev.mk
include makefiles/tum-latex.mk
include makefiles/reshuffle.mk
	
	