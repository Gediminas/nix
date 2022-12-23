#!/bin/sh

SYSTEM=$1
ACTION=$2

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
sudo nixos-rebuild ${ACTION} --flake "${DIR}/.#${SYSTEM}"

#pushd $DIR
##sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
#sudo nixos-rebuild switch --flake .#
#popd

