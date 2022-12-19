#!/bin/sh

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
sudo nixos-rebuild switch --flake "${DIR}/.#"

#pushd $DIR
##sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
#sudo nixos-rebuild switch --flake .#
#popd

