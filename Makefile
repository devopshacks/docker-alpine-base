DOCKER_IMAGE_NAME = devopshacks/docker-alpine-base
DOCKER_IMAGE_TAG ?= latest

default:

build:
	docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

upload:
	docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

test-bash:
	docker run -it --rm ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} bash
