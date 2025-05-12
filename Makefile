setup:
	@docker build --progress=plain -f Containerfile -t cells .

destroy:
	@docker rm -fv cells || true

up: PORT = 8080
up:
	@docker run --rm --name cells \
        -p 127.0.0.1:$(PORT):80 \
        -d \
        cells
	@docker logs -f cells

down:
	@docker stop cells || true
	@while [ $$(docker ps -q -f "name=cells" -f "status=removing" | wc -l) -gt 0 ]; do sleep 1; done

shell:
	@docker exec -it cells sh
