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
$ space -m docker-compose /enter/ -econtainer=space_container
```  

Enter into shell in container and use bash tab completion to help you find the container name:  
```sh
$ space -m docker-compose /enter/ -ecomposename=space -econtainer=[tab][tab]
```

In the above example the module will filter auto completion container names on `composename`.

Exit status code is expected to be 0 on success.
