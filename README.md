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

| BUILD ARGUMENT | Explanation                                                                                                                          |
| -------------  | -------------                                                                                                                        |
| `http_proxy`   | http proxy                                                                                                                           |
| `https_proxy`  | https proxy                                                                                                                          |
| `no_proxy`     | no proxy                                                                                                                             |
| `GOCD_VERSION` | Gocd Version to build. Default to 17.10.0                                                                                            |
| `UID`          | UID for go user. Default to 1000                                                                                                     |
| `GID`          | GID for go group. Default to 1000                                                                                                    |
| `LANG`         | LANG settings. Defaults to en_AU.utf8                                                                                                |
| `GOCD_URL`     | URL to download the gocd release from. Default to https://download.gocd.org/binaries/17.10.0-5380/generic/go-server-17.10.0-5380.zip |
| `GOCD_GIT_SHA` | Sha for the gocd image. Default to `05598d88fd4dabdde1184faa4fbffc5f9406d0dc`                                                        |

## Pull Image

You can pull the prebuilt docker image using
```
docker pull ramz/gocd-server:17.10.0
```

## Run Image
```
docker run -d -p8153:8153 -p8154:8154 ramz/gocd-server:17.10.0
```

### Runtime Configs
The GoCD server will store all configuration, pipeline history database, artifacts, plugins, and logs into /godata. If you'd like to provide secure credentials like SSH private keys among other things, you can mount /home/go

```
docker run -v /path/to/godata:/godata -v /path/to/home-dir:/home/go ramz/gocd-server:17.10.0
```

### Directory Structure

The GoCD server runs as the go user, the location of the various directories is:


| Directory           | Description                                                                      |
|---------------------|----------------------------------------------------------------------------------|
| `/godata/addons`    | the directory where GoCD addons are stored                                       |
| `/godata/artifacts` | the directory where GoCD artifacts are stored                                    |
| `/godata/config`    | the directory where the GoCD configuration is store                              |
| `/godata/db`        | the directory where the GoCD database and configuration change history is stored |
| `/godata/logs`      | the directory where GoCD logs will be written out to                             |
| `/godata/plugins`   | the directory containing GoCD plugins                                            |
| `/home/go`          | the home directory for the GoCD server                                           |
