---
modulename: Docker-compose
title: /up/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Up

Deploy and launch services using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

Deploying a set of services defined in `docker-compose.yaml` configuration file:
```sh
space -m docker-compose /up/ -- docker-compose.yaml
```

Optionally, it is possible to tag the services with a name:
```sh
space -m docker-compose /up/ -- docker-compose.yaml "newcompose"
```

Exit status code is expected to be 0 on success.
