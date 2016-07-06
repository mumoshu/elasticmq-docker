ELASTICMQ_VERSION ?= 0.7.1
VERSION ?= 0.9.0
REPOSITORY ?= mumoshu/elasticmq
TAG ?= $(ELASTICMQ_VERSION)-$(VERSION)
IMAGE ?= $(REPOSITORY):$(TAG)
ALIAS ?= $(REPOSITORY):$(ELASTICMQ_VERSION)
BUILD_ROOT ?= build/$(TAG)
DOCKERFILE ?= $(BUILD_ROOT)/Dockerfile
RUNFILE ?= $(BUILD_ROOT)/run
DOCKER_CACHE ?= docker-cache

build: $(DOCKERFILE) $(RUNFILE)
	cd $(BUILD_ROOT) && docker build -t $(IMAGE) . && docker tag $(IMAGE) $(ALIAS)

publish:
	docker push $(IMAGE) && docker push $(ALIAS)

clean:
	rm -Rf $(BUILD_ROOT)

$(DOCKERFILE): $(BUILD_ROOT)
	sed 's/%%ELASTICMQ_VERSION%%/'"$(ELASTICMQ_VERSION)"'/g;' Dockerfile.template > $(DOCKERFILE)

$(RUNFILE): $(BUILD_ROOT)
	cp run $(RUNFILE)

$(BUILD_ROOT):
	mkdir -p $(BUILD_ROOT)

travis-env:
	travis env set DOCKER_EMAIL $(DOCKER_EMAIL)
	travis env set DOCKER_USERNAME $(DOCKER_USERNAME)
	travis env set DOCKER_PASSWORD $(DOCKER_PASSWORD)

test:
	@echo There are no tests available for now. Skipping

save-docker-cache: $(DOCKER_CACHE)
	docker save $(IMAGE) $(shell docker history -q $(IMAGE) | tail -n +2 | grep -v \<missing\> | tr '\n' ' ') > $(DOCKER_CACHE)/image.tar
	ls -lah $(DOCKER_CACHE)

load-docker-cache: $(DOCKER_CACHE)
	if [ -e $(DOCKER_CACHE)/image.tar ]; then docker load < $(DOCKER_CACHE)/image.tar; fi

$(DOCKER_CACHE):
	mkdir -p $(DOCKER_CACHE)
