---
modulename: Docker-compose
title: /wrap_exec/
giturl: gitlab.com/space-sh/docker-compose
editurl: /edit/master/doc/wrap_exec.md
weight: 200
---
# Docker-compose module: Execute wrap

Execute a command inside an existing container. This command is the same as the one from _Docker_ module.

## Example

Run node named `/info/` from _OS_ module inside an existing container named `space_container`:
```sh
space -m os /info/ -m docker-compose /wrap_exec/ -econtainer=space_container
```

Output:
```sh
[INFO]  OS_INFO: OS type: gnu.
[INFO]  OS_INFO: OS init system: systemd.
[INFO]  OS_INFO: OS package manager: apt.
[INFO]  OS_INFO: OS home directory: /home.
[INFO]  OS_INFO: Current directory: /..
```
