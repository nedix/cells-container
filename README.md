# [cells-container](https://github.com/nedix/cells-container)

## Usage

#### 1. Start the service

This example command will start the server on port 8080.

```shell
docker run --pull always --rm --name cells \
    -p 127.0.0.1:8080:80 \
    nedix/cells
```

#### 2. Configure using the installation wizard

- Navigate to the Cells installation wizard on http://127.0.0.1:8080
