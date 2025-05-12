# [cells-container](https://github.com/nedix/cells-container)

## Usage

#### 1. Start the service

This command will start the service on port `8080`:

```shell
docker run --pull always --rm --name cells \
    -p 127.0.0.1:8080:80 \
    nedix/cells
```

#### 2. Run the configuration wizard

Open a browser window to http://127.0.0.1:8080.
