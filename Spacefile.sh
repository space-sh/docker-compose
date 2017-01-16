#
# Copyright 2017 Blockie AB
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

clone os docker string

#======================
# DOCKER_COMPOSE_DEP_INSTALL
#
# Verify that Docker Engine and Compose are both
# installed otherwise install them.
#
# Parameters:
#   $1: user to add to docker group.
#   $2: the compose version to download and install (optional).
#
# Expects:
#   ${SUDO}: set to "sudo" to run as sudo.
#
# Returns:
#   0: success
#   1: failure
#
#======================
DOCKER_COMPOSE_DEP_INSTALL()
{
    SPACE_SIGNATURE="targetuser [composeversion]"
    SPACE_DEP="PRINT OS_IS_INSTALLED DOCKER_INSTALL DOCKER_COMPOSE_INSTALL"

    local targetuser="${1}"
    shift

    local composeversion="${1-}"
    shift $(( $# > 0 ? 1 : 0 ))

    if OS_IS_INSTALLED "docker"; then
        PRINT "Docker is already installed. To reinstall run: space -m docker /install/." "ok"
    else
        DOCKER_INSTALL "${targetuser}"
        if [ "$?" -gt 0 ]; then
            return 1
        fi
    fi

    if OS_IS_INSTALLED "docker-compose"; then
        PRINT "Docker Compose is already installed. To reinstall run: space -m docker-compose /install/." "ok"
    else
        DOCKER_COMPOSE_INSTALL "${targetuser}" ${composeversion}
    fi

    # Read docker-compose version
    local _version_output=
    local _version=
    local _version_maj=
    local _versions_min=
    _version_output="$(docker-compose -v)"
    _version="${_version_output#docker-compose version }"
    _version="${_version%,*}"
    _version_maj="${_version%%.*}"
    _version_min="${_version#*.}"
    _version_min="${_version_min%.*}"

    # Check docker-compose version meets minimum requirements
    local _required_maj="1"
    local _required_min="6"
    if [ "$_version_maj" -lt "$_required_maj" ] \
        || ( [ "$_version_maj" -le "$_required_maj" ] && [ "$_version_min" -lt "$_required_min" ]); then
        PRINT "Minimum required docker-compose version is: ${_required_maj}.${_required_min}. Current version is: ${_version_maj}.${_version_min}." "error"
        return 1
    else
        PRINT "Current docker-compose version: $_version" "debug"
    fi
}

#======================
# DOCKER_COMPOSE_INSTALL
#
# Install latest Docker on and make it available to the user.
#
# Parameters:
#   $1: user to add to docker group.
#   $2: the compose version to download and install (optional).
#
# Expects:
#   ${SUDO}: set to "sudo" to run as sudo.
#
# Returns:
#   0: success
#   1: failure
#
#======================
DOCKER_COMPOSE_INSTALL()
{
    SPACE_SIGNATURE="targetuser [composeversion]"
    SPACE_DEP="PRINT OS_IS_INSTALLED DOCKER_INSTALL"
    SPACE_ENV="SUDO=\${SUDO-}"

    local targetuser="${1}"
    shift

    local composeversion="${1:-1.9.0}"
    shift $(( $# > 0 ? 1 : 0 ))

    local SUDO="${SUDO-}"

    PRINT "Install Docker Engine and Compose.." "info"

    DOCKER_INSTALL "${targetuser}" &&
    OS_IS_INSTALLED "curl" "curl" &&
    ${SUDO} curl -sSL "https://github.com/docker/compose/releases/download/{$composeversion}/docker-compose-$(uname -s)-$(uname -m)" | ${SUDO} tee "/usr/local/bin/docker-compose" &&
    ${SUDO} chmod +x /usr/local/bin/docker-compose
}

#=====================
# DOCKER_COMPOSE
#
# Wrapper for `docker-compose`.
#
# Parameters:
#   $@: arguments passed on
#
# Returns:
#   non-zero on error.
#
#=====================
DOCKER_COMPOSE()
{
    SPACE_SIGNATURE="args"
    docker-compose "${@}"
}

#=====================
# DOCKER_COMPOSE_UP
#
# Take a docker compose file and deploy it.
#
# This is wrapper so that we can figure out the yaml path
# and set the redirection correctly.
#
# Parameters:
#   $1: path to docker compose yaml file to use.
#   $2: name, optional name for the compose.
#
# Returns:
#   non-zero on error.
#
#=====================
DOCKER_COMPOSE_UP()
{
    SPACE_SIGNATURE="composefile [name]"
    SPACE_FN="DOCKER_COMPOSE"
    SPACE_DEP="STRING_SUBST"

    local composefile="${1}"
    shift

    local name=""
    if [ ! "${1+set}" = "set" ]; then
        name="${composefile%.yaml*}"
        name="${name##*/}"
        name="${name%_docker-compose}"
        # Make name docker friendly.
        STRING_SUBST "name" "-" "" 1
        STRING_SUBST "name" "_" "" 1
        STRING_SUBST "name" "." "" 1
    else
        # Prefix is given, could be "".
        local name="${1}"
        shift
    fi

    if [ ! -f "${composefile}" ]; then
        PRINT "Docker Compose file: ${composefile} not found." "error"
        return 1
    fi

    SPACE_REDIR="<${composefile}"
    SPACE_ARGS="-f - -p \"${name}\" up -d"
}

#=======================
# DOCKER_COMPOSE_DOWN
#
# Take a docker compose file and un-deploy it.
#
# This is wrapper so that we can figure out the yaml path
# and set the redirection correctly.
#
# Parameters:
#   $1: path to docker compose yaml file to use.
#   $2: name, optional name for the compose.
#
# Returns:
#   non-zero on error.
#
#=======================
DOCKER_COMPOSE_DOWN()
{
    SPACE_SIGNATURE="composefile [name]"
    SPACE_FN="DOCKER_COMPOSE"
    SPACE_DEP="STRING_SUBST"

    local composefile="${1}"
    shift

    local name=""
    if [ ! "${1+set}" = "set" ]; then
        name="${composefile%.yaml*}"
        name="${name##*/}"
        name="${name%_docker-compose}"
        # Make name docker friendly.
        STRING_SUBST "name" "-" "" 1
        STRING_SUBST "name" "_" "" 1
        STRING_SUBST "name" "." "" 1
    else
        # Prefix is given, could be "".
        local name="${1}"
        shift
    fi

    if [ ! -f "${composefile}" ]; then
        PRINT "Docker Compose file: ${composefile} not found." "error"
        return 1
    fi

    SPACE_REDIR="<${composefile}"
    SPACE_ARGS="-f - -p \"${name}\" down"
}

#=======================
# DOCKER_COMPOSE_PS
#
# Take a docker compose file and check the status of the services.
#
# This is wrapper so that we can figure out the yaml path
# and set the redirection correctly.
#
# Parameters:
#   $1: path to docker compose yaml file to use.
#   $2: name, optional name for the compose.
#
# Returns:
#   non-zero on error.
#
#=======================
DOCKER_COMPOSE_PS()
{
    SPACE_SIGNATURE="composefile [name]"
    SPACE_FN="DOCKER_COMPOSE"
    SPACE_DEP="STRING_SUBST"

    local composefile="${1}"
    shift

    local name=""
    if [ ! "${1+set}" = "set" ]; then
        name="${composefile%.yaml*}"
        name="${name##*/}"
        name="${name%_docker-compose}"
        # Make name docker friendly.
        STRING_SUBST "name" "-" "" 1
        STRING_SUBST "name" "_" "" 1
        STRING_SUBST "name" "." "" 1
    else
        # Prefix is given, could be "".
        local name="${1}"
        shift
    fi

    if [ ! -f "${composefile}" ]; then
        PRINT "Docker Compose file: ${composefile} not found." "error"
        return 1
    fi

    SPACE_REDIR="<${composefile}"
    SPACE_ARGS="-f - -p \"${name}\" ps"
}

#=======================
# DOCKER_COMPOSE_LOGS
#
# Take a docker compose file and get the logs of the services.
#
# This is wrapper so that we can figure out the yaml path
# and set the redirection correctly.
#
# Parameters:
#   $1: path to docker compose yaml file to use.
#   $2: name, optional name for the compose.
#
# Returns:
#   non-zero on error.
#
#=======================
DOCKER_COMPOSE_LOGS()
{
    SPACE_SIGNATURE="composefile [name]"
    SPACE_FN="DOCKER_COMPOSE"
    SPACE_DEP="STRING_SUBST"

    local composefile="${1}"
    shift

    local name=""
    if [ ! "${1+set}" = "set" ]; then
        name="${composefile%.yaml*}"
        name="${name##*/}"
        name="${name%_docker-compose}"
        # Make name docker friendly.
        STRING_SUBST "name" "-" "" 1
        STRING_SUBST "name" "_" "" 1
        STRING_SUBST "name" "." "" 1
    else
        # Prefix is given, could be "".
        local name="${1}"
        shift
    fi

    if [ ! -f "${composefile}" ]; then
        PRINT "Docker Compose file: ${composefile} not found." "error"
        return 1
    fi

    SPACE_REDIR="<${composefile}"
    SPACE_ARGS="-f - -p \"${name}\" logs"
}

#====================
# DOCKER_COMPOSE_EXEC
#
# Exec a command inside a docker container.
#
# The "name" is the name of the Docker composition, which usually is the
# part of the docker compose file as "name-docker-compose.yaml".
#
# The "container" is the container name as stated in the docker compse yaml file
# (without any index prefix).
#
# flags are usually set to "-i" or "-it" if you want a terminal connected.
#
# cmd could be "/bin/sh", "/bin/sh -c", etc.
# An interactive shell would simply be "sh", "bash", "/bin/sh" or similar.
# A shell which runs arguments passed to it would typically have the "-c" option set.
#
# args are the arguments passed to the "cmd".
# If "cmd" is a shell with the -c option set then "args" are expected.
#
# Parameters:
#   $1: name, optional name for the composition.
#   $2: container the name of the container (excluding index prefix which is set to 1).
#   $3: docker exec flags
#   $4: cmd command to run, ex "sh -c".
#   $5: args, optional args to cmd.
#
# Returns:
#   non-zero on error.
#
#====================
DOCKER_COMPOSE_EXEC()
{
    SPACE_SIGNATURE="name container flags cmd [args]"
    SPACE_FN="DOCKER_EXEC"
    SPACE_DEP="STRING_SUBST"

    local name="${1}"
    shift

    local container="${1}"
    shift

    local flags="${1:--ti}"
    shift

    local cmd="${1}"
    shift

    # Make name docker friendly.
    STRING_SUBST "name" "-" "" 1
    STRING_SUBST "name" "_" "" 1
    STRING_SUBST "name" "." "" 1

    if [ -n "${name}" ]; then
        container="${name}_${container}"
    fi

    local index="1"
    container="${container}_${index}"

    SPACE_ARGS="\"${container}\" \"${flags}\" \"${cmd}\" \"${@}\""
}

#=====================
# DOCKER_COMPOSE_ENTER
#
# Enter into shell in a docker container.
#
# Parameters:
#   $1: name, optional name for the composition.
#   $2: container the name of the container (excluding index prefix which is set to 1).
#   $3: cmd, optional shell, defaults to "sh".
#
# Returns:
#   non-zero on error
#
#=====================
DOCKER_COMPOSE_ENTER()
{
    SPACE_SIGNATURE="name container [cmd]"
    SPACE_FN="DOCKER_ENTER"
    SPACE_DEP="STRING_SUBST"

    local name="${1}"
    shift

    local container="${1}"
    shift

    # Make name docker friendly.
    STRING_SUBST "name" "-" "" 1
    STRING_SUBST "name" "_" "" 1
    STRING_SUBST "name" "." "" 1

    if [ -n "${name}" ]; then
        container="${name}_${container}"
    fi

    local index="1"
    container="${container}_${index}"

    local cmd="${1-}"
    shift $(( $# > 0 ? 1 : 0 ))

    SPACE_ARGS="\"${container}\" \"${cmd}\""
}

#=============================
#
# _DOCKER_COMPOSE_SHEBANG_OUTER()
#
#
#=============================
_DOCKER_COMPOSE_SHEBANG_OUTER()
{
    SPACE_SIGNATURE="composefile name command [args]"
    SPACE_DEP="PRINT"

    local composefile="${1}"
    shift

    local name="${1}"
    shift

    local cmd="${1}"
    shift

    if [ "${cmd}" = "help" ]; then
        printf "%s\n" "This is the SpaceGal wrapper over docker-compose.
Pass in a COMMAND which will get passed on to docker-compose:
    up
    down
    stop
    ps
    logs
    etc

Example:
    ${composefile} -- up
    ${composefile} -- up -d  (to detach from it so it runs in background)

This will deploy the compose file using the local docker-compose.
To deploy onto a remote server you could sneak in the space ssh module
and wrap the command, kind of like:
${composefile} -m ssh /user/wrap/ -esshuser=astro -esshkeyfile= -esshhost=example.com -- UP
Notice that all arguments before the '--' are arguments to Space, arguments after '--' are
arguments to Space's 'docker-compose' module.

"
        return
    fi

    if [ ! -f "${composefile}" ]; then
        PRINT "Docker Compose file: ${composefile} not found." "error"
        return 1
    fi

    _CMD_
}

#=====================
# DOCKER_COMPOSE_SHEBANG
#
# Handle the "shebang" invocations of docker-compose files.
#
# Parameters:
#   $1: path to docker compose yaml file to use.
#   $2: docker-compose command to run
#   $@: optional args for the command
#
# Returns:
#   non-zero on error
#
#=====================
DOCKER_COMPOSE_SHEBANG()
{
    SPACE_SIGNATURE="composefile [command] [args]"
    SPACE_DEP="PRINT STRING_SUBST"
    SPACE_FN="DOCKER_COMPOSE"
    SPACE_OUTER="_DOCKER_COMPOSE_SHEBANG_OUTER"

    local composefile="${1}"
    shift

    local cmd="${1:-help}"
    shift $(( $# > 0 ? 1 : 0 ))

    local name=""
    name="${composefile%.yaml*}"
    name="${name##*/}"
    name="${name%_docker-compose}"
    # Make name docker friendly.
    STRING_SUBST "name" "-" "" 1
    STRING_SUBST "name" "_" "" 1
    STRING_SUBST "name" "." "" 1

    if [ -z "${name}" ]; then
        PRINT "Could not extract a name for the composition. Rename the file into the format of NAME.yaml" "error"
        return 1
    fi

    SPACE_OUTERARGS="${composefile} ${name} ${cmd} ${@}"

    SPACE_REDIR="<${composefile}"
    SPACE_ARGS="-f - -p \"${name}\" ${cmd} $@"
}
