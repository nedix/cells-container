setup:
	@docker build --progress=plain -f Containerfile -t cells .

up: PORT = 8080
up:
	@docker run --rm --name cells \
        -p 127.0.0.1:$(PORT):8080 \
        cells
