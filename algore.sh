#!/bin/bash

# algore: he cares about the environment

# use: algore [env file]
# options: -h/--help, -v/--version, -l/--list, -c/--current

# display help
if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "algore: he cares about the environment"
    echo "use: algore [env file]"
    echo "options: -h/--help, -v/--version, -l/--list, -c/--current"
    exit 0
fi

# display version
if [[ $1 == "-v" || $1 == "--version" ]]; then
    echo "algore version 0.0.1"
    exit 0
fi

# display list of environments
if [[ $1 == "-l" || $1 == "--list" ]]; then
    # list all files starting with .env.
    # TODO: if no files found, check containing directory
    LIST=$(ls -1 .env.*)
    if [ $? -ne 0 ]; then
        echo "error listing environments"
    elif [[ $LIST == "" ]]; then
        echo "no environments found"
    else
        echo $LIST
    fi
    exit 0
fi

# display current environment
if [[ $1 == "-c" || $1 == "--current" ]]; then
    # check if .env file exists
    # if so, print last line without leading two characters
    # if not, print "no environment set"
    if [ -f .env ]; then
        echo $(tail -n 1 .env | cut -c 3-)
    else
        echo "no environment set"
    fi
    exit 0
fi

# set environment

# check if file exists
# if so, cp current .env to .env.bak
# then cp new .env to .env
# and append commented env name to .env
# if not, print "environment not found"
if [ -f ".env.${1}" ]; then
    if [ -f .env ]; then
        cp .env .env.bak
    fi
    cp ".env.${1}" .env
    echo -e "\n# ${1}" >> .env
else
    echo "environment not found"
fi

exit 0
