reshuffle:
	DOCKER_BUILDKIT=1 ${DOCKER_BUILD} -t reshuffle -f reshuffle.dockerfile \
	--platform ${PLATFORMS} .
	
pull-reshuffle:
	docker pull santiagonar1/reshuffle:${TAG}
	
push-reshuffle: reshuffle login
	docker tag reshuffle santiagonar1/reshuffle:${TAG}
	docker push santiagonar1/reshuffle:${TAG}