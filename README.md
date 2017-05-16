# Docker Compose management. | [![build status](https://gitlab.com/space-sh/docker-compose/badges/master/build.svg)](https://gitlab.com/space-sh/docker-compose/commits/master)


## /down/
	Un-deploy services using docker-compose


## /enter/
	Enter with a shell into a running container

	Set variable composename to have auto
	completion be filtered on that.
	


## /exec/
	Exec command in service using docker

	Set variable composename to have auto
	completion be filtered on that.
	


## /install/
	Install the latest Docker Compose

	Downloads and installs the latest Docker Compose.
	Will reinstall if already installed.
	


## /logs/
	Get logs of services using docker-compose


## /ps/
	Get status of services using docker-compose


## /pull/
	Pull all service images using docker-compose


## /rm/
	Remove all services using docker-compose


## /up/
	Deploy services using docker-compose

	Launch services using "docker-compose".
	


# Functions 

## DOCKER\_COMPOSE\_DEP\_INSTALL()  
  
  
  
Verify that Docker Engine and Compose are both  
installed otherwise install them.  
  
### Parameters:  
- $1: user to add to docker group.  
- $2: the compose version to download and install (optional).  
  
### Returns:  
- 0: success  
- 1: failure  
  
  
  
## DOCKER\_COMPOSE\_INSTALL()  
  
  
  
Install latest Docker Compose.  
  
### Parameters:  
- $1: the compose version to download and install (optional).  
  
### Returns:  
- 0: success  
- 1: failure  
  
  
  
## DOCKER\_COMPOSE()  
  
  
  
Wrapper for `docker-compose`.  
  
### Parameters:  
- $@: arguments passed on  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_UP()  
  
  
  
Take a docker compose file and deploy it.  
  
This is wrapper so that we can figure out the yaml path  
and set the redirection correctly.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: name, optional name for the compose.  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_DOWN()  
  
  
  
Take a docker compose file and un-deploy it.  
  
This is wrapper so that we can figure out the yaml path  
and set the redirection correctly.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: name, optional name for the compose.  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_PS()  
  
  
  
Take a docker compose file and check the status of the services.  
  
This is build time function that sets a wrapper so that we can  
figure out the yaml path and set the redirection correctly.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: name, optional name for the compose.  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_PULL()  
  
  
  
Take a docker compose file and pull images for all services.  
  
This is wrapper so that we can figure out the yaml path  
and set the redirection correctly.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: name, optional name for the compose.  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_RM()  
  
  
  
Take a docker compose file and remove all services.  
  
This is wrapper so that we can figure out the yaml path  
and set the redirection correctly.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: name, optional name for the compose.  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_LOGS()  
  
  
  
Take a docker compose file and get the logs of the services.  
  
This is wrapper so that we can figure out the yaml path  
and set the redirection correctly.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: name, optional name for the compose.  
  
### Returns:  
- non-zero on error.  
  
  
  
## \_DOCKER\_COMPOSE\_SHEBANG\_OUTER()  
  
  
()  
  
  
  
  
## DOCKER\_COMPOSE\_SHEBANG()  
  
  
  
Handle the "shebang" invocations of docker-compose files.  
  
### Parameters:  
- $1: path to docker compose yaml file to use.  
- $2: docker-compose command to run  
- $@: optional args for the command  
  
### Returns:  
- non-zero on error  
  
  
  
