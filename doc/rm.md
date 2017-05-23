---
modulename: Docker-compose
title: /rm/
giturl: gitlab.com/space-sh/docker-compose
editurl: /edit/master/doc/rm.md
weight: 200
---
# Docker-compose module: Remove

Remove all services using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

Remove stopped all stopped services defined in `docker-compose.yaml` configuration file:
```sh
space -m docker-compose /rm/ -- docker-compose.yaml
```

Exit status code is expected to be 0 on success.
