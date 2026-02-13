# [cells-container][project]


## Usage


### 1. Start the container

This command will start the container on port `80`:

```shell
docker run \
    --name cells \
    --pull always \
    --rm \
    -p 127.0.0.1:80:80 \
    nedix/cells
```


### 2. Run the setup wizard

Open a browser window to http://127.0.0.1:80.


[project]: https://hub.docker.com/r/nedix/cells
