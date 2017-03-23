---
modulename: Docker-compose
title: /pull/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Pull

Pull all service images using _Docker Compose_, based on a _Docker Compose_ configuration file.


## Example

```sh
space -m docker-compose /pull/ -- docker-compose.yaml
```

Exit status code is expected to be 0 on success.
