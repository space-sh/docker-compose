---
modulename: Docker-compose
title: /enter/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Enter

Enter with a shell into a running container.


## Example

```sh
space -m docker-compose /enter/ -econtainer=space_container
```

Exit status code is expected to be 0 on success.
