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