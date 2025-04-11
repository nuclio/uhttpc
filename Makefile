# Variables
DOCKER_IMAGE_NAME := quay.io/nuclio/uhttpc
DOCKER_IMAGE_TAG := 0.0.3
DOCKER_BUILD_ARGS := --build-arg GOARCH=amd64
DOCKER_BUILD_ARGS_ARMHF := --build-arg GOARCH=arm
DOCKER_BUILD_ARGS_ARM64 := --build-arg GOARCH=arm64
MAKEFLAGS += -j3

build-amd64:
	docker build --platform linux/amd64 $(DOCKER_BUILD_ARGS) -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)-amd64 .

build-armhf:
	docker build --platform linux/arm/v7 $(DOCKER_BUILD_ARGS_ARMHF) -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)-armhf .

build-arm64:
	docker build --platform linux/arm64 $(DOCKER_BUILD_ARGS_ARM64) -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)-arm64 .

build-all: build-amd64 build-armhf build-arm64

.PHONY: build-amd64 build-armhf build-arm64 build-all

push-amd64:
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)-amd64

push-armhf:
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)-armhf

push-arm64:
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)-arm64

push-all: push-amd64 push-armhf push-arm64

.PHONY: push-amd64 push-armhf push-arm64 push-all
