---
modulename: Docker-compose
title: /exec/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Execute

Execute a command in service using _Docker Compose_.


## Example

Similar to `exec` node in _Docker_ module. Executes a docker command in services defined in `docker-compose.yaml` configuration file:
```sh
space -m docker-compose /exec/ -econtainer=space_container ecmd="/bin/ls"
```

Exit status code is expected to be 0 on success.
