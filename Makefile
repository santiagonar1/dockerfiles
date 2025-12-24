PLATFORMS = linux/amd64,linux/arm64
TAG = latest

# We need buildx to have multi-platforms build on the CI
DOCKER_BUILD = docker buildx build

.PHONY: help
	
help:
	@echo "Check Makefile for options"

login:
	docker login
	
cpp-dev:
	DOCKER_BUILDKIT=1 ${DOCKER_BUILD} -t cpp-dev -f cpp-dev.dockerfile \
	--platform ${PLATFORMS} .

pull-cpp-dev:
	docker pull santiagonar1/cpp-dev:${TAG}
	
push-cpp-dev: cpp-dev login
	docker tag cpp-dev santiagonar1/cpp-dev:${TAG}
	docker push santiagonar1/cpp-dev:${TAG}
	
tum-latex:
	$(eval GITLAB_API := https://gitlab.lrz.de/api/v4)
	$(eval PROJECT_ID := 33555)
	$(eval TUM_TEMPLATES_VERSION := main)

	$(eval PACKAGE_REGISTRY := $(GITLAB_API)/projects/$(PROJECT_ID)/packages/generic)
	$(eval PACKAGE_PATH := linux-installer/$(TUM_TEMPLATES_VERSION))
	$(eval PACKAGE_FILE := tum-templates-$(TUM_TEMPLATES_VERSION).tar.gz)

	DOCKER_BUILDKIT=1 ${DOCKER_BUILD} -t tum-latex -f tum-latex.dockerfile \
	 --secret id=gitlab_token,env=GITLAB_TOKEN \
	 --platform ${PLATFORMS} \
	 --build-arg INSTALLER_URL=$(PACKAGE_REGISTRY)/$(PACKAGE_PATH)/$(PACKAGE_FILE) .

pull-tum-latex:
	docker pull santiagonar1/tum-latex:${TAG}
	
push-tum-latex: tum-latex login
	docker tag tum-latex santiagonar1/tum-latex:${TAG}
	docker push santiagonar1/tum-latex:${TAG}
	
	