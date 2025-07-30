#/usr/bin/env bash

user=$1
host=$2

if [[ -z $user ]]; then
    user=$USER
fi

if [[ -z $hostname ]]; then
    host=`hostname -s`
fi

home-manager switch -b backup --flake .#$user@$host
