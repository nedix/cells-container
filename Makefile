setup:
	@docker build --progress=plain -f Containerfile -t cells .

destroy:
	-@docker rm -fv cells

up: HTTP_PORT = "80"
up:
	@docker run --rm -d --name cells \
        -p 127.0.0.1:$(HTTP_PORT):80 \
        cells
	@docker logs -f cells

down:
	-@docker stop cells

shell:
	@docker exec -it cells /bin/sh

test:
	@$(CURDIR)/tests/index.sh
