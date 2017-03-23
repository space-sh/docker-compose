---
modulename: Docker-compose
title: /install/
giturl: gitlab.com/space-sh/docker-compose
weight: 200
---
# Docker-compose module: Install

Downloads and installs the latest _Docker Compose_, overwritting existing installation.


## Example

Issuing install or reinstall of latest recommended _Docker Compose_ version:
```sh
space -m docker-compose /install/
```

_Docker Compose_ version can be explicitly defined with optional argument:
```sh
space -m docker-compose /install/ -- "1.9.0"
```

Exit status code is expected to be 0 on success.
