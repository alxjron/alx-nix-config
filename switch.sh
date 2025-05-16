#/usr/bin/env bash

user=$1
host=$2

if [[ -z $user ]]; then
    user=$USER
fi

if [[ -z $hostname ]]; then
    host=`hostname -s`
fi

sudo nixos-rebuild switch --upgrade --flake .#$host
home-manager switch --flake .#$user@$host
