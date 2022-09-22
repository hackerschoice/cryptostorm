all: Dockerfile
	docker build -t hackerschoice/cryptostorm .

push: Dockerfile
	docker buildx build \
	--push \
	--platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag hackerschoice/cryptostorm .

