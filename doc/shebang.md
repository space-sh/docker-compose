---
modulename: Docker-compose
title: Shebang
giturl: gitlab.com/space-sh/docker-compose
editurl: /edit/master/doc/shebang.md
weight: 200
---
# Docker-compose module: #!shebang

You can make your `docker-compose.yaml` executable by adding a `shebang line as first
line in the YAML file.  

As you might know the shebang line is the first line in a shell script that determines which
interpretor to run for the script. For Bash scripts it is usually `#!/bin/env bash`.

We can add a shebang line that tells the kernel that we want the _Space_ module
_docker-compose_ to be the interpreter so it can directly run the yaml file.

For Linux add this line as the very first line in your `docker-compose.yaml` file:  
```sh
#!/usr/bin/space -m docker-compose /_shebang/
```

For MacOS systems add this line instead:  
```sh
#!/usr/bin/env space ! -m docker-compose /_shebang/ !
```

Then you need to make the yaml file executable:  

```sh
$ chmod +x docker-compose.yaml
```

Alright, it should be runnable directly from command line:  
```sh
$ ./docker-compose.yaml -- up
$ ./docker-compose.yaml -- ps
$ ./docker-compose.yaml -- down
```

Pretty neat, uh?  

Oh, there is more. We can wrap it using the SSH module to have it being deployed remotely:  

```sh
$ ./docker-compose.yaml -m ssh /wrap/ -eSSHHOST=address -- up
```

It is important to add `-m ssh /wrap/ -eSSHHOST=address` before the double dash `--`.
Because everything left of `--` are arguments to _Space_ and everything to the right of `--`
are arguments to the module.

Remember, that if you want to see the magic behind the scenes, add the `-d` flag to _Space_
to have it dump out the script for debugging, inspection and sharing.
