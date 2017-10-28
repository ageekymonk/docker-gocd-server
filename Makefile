SHELL := /bin/bash
WORKING_DIR := $(shell pwd)

DOCKER_REGISTRY ?= hub.docker.com
DOCKER_USERNAME ?= ramz
IMAGE_NAME ?= gocd-server
IMAGE_VERSION ?= latest
IMAGE_TAG = $(DOCKER_REGISTRY)/$(DOCKER_USERNAME)/$(IMAGE_NAME):$(IMAGE_VERSION)

.PHONY: build push

release:: build push

push::
	@docker push $(IMAGE_TAG)

build::
	docker build --pull -t $(IMAGE_TAG) \
								--build-arg=http_proxy=$(http_proxy) \
                --build-arg=https_proxy=$(https_proxy) \
								--build-arg=no_proxy=$(no_proxy) \
								$(WORKING_DIR)
