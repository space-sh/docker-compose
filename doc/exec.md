---
modulename: Docker-compose
title: /exec/
giturl: gitlab.com/space-sh/docker-compose
editurl: /edit/master/doc/exec.md
weight: 200
---
# Docker-compose module: Execute

Execute a command in service using _Docker Compose_.


## Example

Similar to `exec` node in _Docker_ module. Executes a docker command in services defined in `docker-compose.yaml` configuration file:

```sh
space -m docker-compose /exec/ -econtainer=space_container ecmd="/bin/ls"
```

Exec command in container and use bash tab completion to help you find the container name:  
```sh
space -m docker-compose /exec/ -ecomposename=space -econtainer[tab][tab]
```

Exit status code is expected to be 0 on success.
