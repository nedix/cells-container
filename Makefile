setup:
	@docker build --progress=plain -f Containerfile -t cells .

destroy:
	-@docker rm -fv cells

up: HTTP_PORT = "80"
up:
	@docker run \
		--name cells \
		--rm \
		-p 127.0.0.1:$(HTTP_PORT):80 \
		-d \
		cells
	@docker logs -f cells

down:
	-@docker stop cells

shell:
	@docker exec -it cells /bin/sh

test:
	@$(CURDIR)/tests/index.sh
