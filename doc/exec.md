---
modulename: Docker-compose
title: /exec/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Execute

Execute a command in service using _Docker Compose_.


## Example

```sh
space -m docker-compose /exec/ -econtainer=space_container
```

Exit status code is expected to be 0 on success.
