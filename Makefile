.PHONY: build run shell clean

IMAGE_NAME = asdf-taplo-test
CONTAINER_NAME = asdf-test

build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .

run: build
	@echo "Running container..."
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME)

shell: build
	@echo "Starting shell in container..."
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME) /bin/bash

clean:
	@echo "Cleaning up..."
	docker rmi $(IMAGE_NAME) || true
	docker rm $(CONTAINER_NAME) || true

test: build
	@echo "Running tests in container..."
	docker run --rm $(IMAGE_NAME) bash -c "source ~/.asdf/asdf.sh && asdf install taplo latest && asdf global taplo latest && taplo --version"
