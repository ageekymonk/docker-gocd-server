# GOCD Server Docker Image
Alpine based Docker Container for gocd server

## Build Docker Image

### Build Image
```
make build
```

you can overwrite `DOCKER_REGISTRY`, `DOCKER_USERNAME`, `IMAGE_NAME`, `IMAGE_VERSION`

export `http_proxy`, `https_proxy` and `no_proxy` for build time proxy settings.

### Push Image to registry
```
make push
```

### Build and Push
```
make release
```

### Build Arguments

| ARGUMENT       |               |
| -------------  | ------------- |
| `http_proxy`   | Content Cell  |
| `https_proxy`  | Content Cell  |
| `no_proxy`     |               |
| `GOCD_VERSION` |               |
| `UID`          |               |
| `GID`          |               |
| `LANG`         |               |
|                |               |
