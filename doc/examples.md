---
modulename: Docker-compose
title: Examples
giturl: gitlab.com/space-sh/docker-compose
editurl: /edit/master/doc/examples.md
weight: 200
---
# Docker Compose Module

The Space.sh Docker Compose module is an interface to the Docker Compose command line tool.  
By having an interface to the Docker compose tool we can apply the Space.sh power to it.  

## Deploy a compose file over SSH

To deploy a `docker-compose.yaml` file locally, simply do:  

```sh
space -m docker-compose /up/ -- docker-compose.yaml
```

Or preferably using `-e` variables:  

```sh
space -m docker-compose /up/ -e composefile=docker-compose.yaml
```

Then to deploy the compose over ssh (without uploading the file),
we simly wrap it using the SSH module:  

```sh
space -m docker-compose /up/ -e composefile=docker-compose.yaml \
    -d ssh /wrap/ -e SSHHOST=address
```

Check its status using the `/ps/` node:  

```sh
space -m docker-compose /ps/ -e composefile=docker-compose.yaml \
    -d ssh /wrap/ -e SSHHOST=address
```

Or why not enter into a running container on the remote host:  

```sh
space -m docker-compose /enter/ -e container=[tab][tab] \
    -d ssh /wrap/ -e SSHHOST=address
```

Note that for the auto completion to work in this case you must have ssh login keys setup,
because entering a password when tab completing will not work.  
