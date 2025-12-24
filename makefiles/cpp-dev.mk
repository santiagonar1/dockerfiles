cpp-dev:
	DOCKER_BUILDKIT=1 ${DOCKER_BUILD} -t cpp-dev -f cpp-dev.dockerfile \
	--platform ${PLATFORMS} .

pull-cpp-dev:
	docker pull santiagonar1/cpp-dev:${TAG}
	
push-cpp-dev: cpp-dev login
	docker tag cpp-dev santiagonar1/cpp-dev:${TAG}
	docker push santiagonar1/cpp-dev:${TAG}