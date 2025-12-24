mpi-dev:
	DOCKER_BUILDKIT=1 ${DOCKER_BUILD} -t mpi-dev -f mpi-dev.dockerfile \
	--platform ${PLATFORMS} .
	
pull-mpi-dev:
	docker pull santiagonar1/mpi-dev:${TAG}
	
push-mpi-dev: mpi-dev login
	docker tag mpi-dev santiagonar1/mpi-dev:${TAG}
	docker push santiagonar1/mpi-dev:${TAG}