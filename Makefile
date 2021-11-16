SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help
.PHONY: help download download-yaml container shell

DOCKER_IMG = registry.gitlab.com/cremsburg/juniper-automation-container
DOCKER_TAG = 0.1.2

help:
	@echo ''
	@echo 'Makefile will help us build with the following commands'
	@echo '		make download				download the device configuration'
	@echo '		make download-yaml				download the device configuration as yaml'
	@echo '		make container				builds the docker container'
	@echo '		make shell				runs the container and gives you access to its shell'

download:
	docker run -it \
	--rm \
	-v $(PWD)/files/:/home/tmp/files \
	-v $(PWD)/files/tmp:/tmp \
	-w /home/tmp/files/ansible/ \
	$(DOCKER_IMG):$(DOCKER_TAG) ansible-playbook pb.config.download.yaml

download-yaml:
	docker run -it \
	--rm \
	-v $(PWD)/files/:/home/tmp/files \
	-v $(PWD)/files/tmp:/tmp \
	-w /home/tmp/files/ansible/ \
	$(DOCKER_IMG):$(DOCKER_TAG) ansible-playbook pb.config.download.vars.yaml

pinecone:
	docker run -it \
	--rm \
	-v $(PWD)/files/:/home/tmp/files \
	-v $(PWD)/files/tmp:/tmp \
	-w /home/tmp/files/ansible/ \
	$(DOCKER_IMG):$(DOCKER_TAG) ansible-playbook pb.config.send.to.pinecone.yaml

container:
	docker build -t $(DOCKER_IMG):$(DOCKER_TAG) files/docker/ansible/

shell:
	docker run -it \
	--rm \
	-v $(PWD)/files/:/home/tmp/files \
	-v $(PWD)/files/tmp:/tmp \
	-w /home/tmp/files/ansible/ \
	$(DOCKER_IMG):$(DOCKER_TAG) /bin/bash
