---
modulename: Docker-compose
title: /enter/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Enter

Enter into shell in a running container.


## Example

Enter into shell in container named `space_container`:
```sh
space -m docker-compose /enter/ -econtainer=space_container
```

Exit status code is expected to be 0 on success.
