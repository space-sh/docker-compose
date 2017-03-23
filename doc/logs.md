---
modulename: Docker-compose
title: /logs/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Logs

Get logs of services using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

```sh
space -m docker-compose /logs/ -- docker-compose.yaml
```

Exit status code is expected to be 0 on success.
