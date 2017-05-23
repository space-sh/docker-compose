---
modulename: Docker-compose
title: /down/
giturl: gitlab.com/space-sh/docker-compose
editurl: /edit/master/doc/down.md
weight: 200
---
# Docker-compose module: Down

Stops and removes services using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

Stopping a set of services defined in `docker-compose.yaml` configuration file:
```sh
space -m docker-compose /down/ -- docker-compose.yaml
```

Optionally, it is possible to specify the services name:
```sh
space -m docker-compose /down/ -- docker-compose.yaml "mycompose"
```

Exit status code is expected to be 0 on success.
