#/usr/bin/env bash

nix-collect-garbage --delete-older-than 30d
nix store optimize
