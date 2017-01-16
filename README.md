# Manage Docker Compose | [![build status](https://gitlab.com/space-sh/docker-compose/badges/master/build.svg)](https://gitlab.com/space-sh/docker-compose/commits/master)

|


## /down/
	Un-deploy services using docker-compose


## /enter/
	Enter with a shell into a running container


## /exec/
	Exec command in service using docker-compose


## /install/
	Install the latest Docker Engine and Compose

	Downloads and installs the latest Docker Engine and Compose
	from Docker.
	Also adds the targetuser to the docker group.
	Will reinstall if already installed.


## /logs/
	Get logs of services using docker-compose


## /ps/
	Get status of services using docker-compose


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
  
### Expects:  
- ${SUDO}: set to "sudo" to run as sudo.  
  
### Returns:  
- 0: success  
- 1: failure  
  
  
  
## DOCKER\_COMPOSE\_INSTALL()  
  
  
  
Install latest Docker on and make it available to the user.  
  
### Parameters:  
- $1: user to add to docker group.  
- $2: the compose version to download and install (optional).  
  
### Expects:  
- ${SUDO}: set to "sudo" to run as sudo.  
  
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
  
  
  
## DOCKER\_COMPOSE\_EXEC()  
  
  
  
Exec a command inside a docker container.  
  
The "name" is the name of the Docker composition, which usually is the  
part of the docker compose file as "name-docker-compose.yaml".  
  
The "container" is the container name as stated in the docker compose yaml file  
(without any index prefix).  
  
flags are usually set to "-i" or "-it" if you want a terminal connected.  
  
cmd could be "/bin/sh", "/bin/sh -c", etc.  
An interactive shell would simply be "sh", "bash", "/bin/sh" or similar.  
A shell which runs arguments passed to it would typically have the "-c" option set.  
  
args are the arguments passed to the "cmd".  
If "cmd" is a shell with the -c option set then "args" are expected.  
  
### Parameters:  
- $1: name, optional name for the composition.  
- $2: container the name of the container (excluding index prefix which is set to 1).  
- $3: docker exec flags  
- $4: cmd command to run, ex "sh -c".  
- $5: args, optional args to cmd.  
  
### Returns:  
- non-zero on error.  
  
  
  
## DOCKER\_COMPOSE\_ENTER()  
  
  
  
Enter into shell in a docker container.  
  
### Parameters:  
- $1: name, optional name for the composition.  
- $2: container the name of the container (excluding index prefix which is set to 1).  
- $3: cmd, optional shell, defaults to "sh".  
  
### Returns:  
- non-zero on error  
  
  
  
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
  
  
  
