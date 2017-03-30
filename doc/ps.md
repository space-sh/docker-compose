---
modulename: Docker-compose
title: /ps/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Process status

Check the status of services using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

List process status for services defined in `docker-compose.yaml` configuration file:
```sh
space -m docker-compose /ps/ -- docker-compose.yaml
```

Exit status code is expected to be 0 on success.
