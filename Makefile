setup:
	@docker build . --tag=cells --progress=plain

up: port = 8080
up:
	@docker run --rm --name cells \
        -p 127.0.0.1:$(port):8080 \
        cells
