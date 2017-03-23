---
modulename: Docker-compose
title: /up/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Up

Launch services using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

```sh
space -m docker-compose /up/ -- docker-compose.yaml
```

Exit status code is expected to be 0 on success.
