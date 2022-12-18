#!/bin/sh

pushd ~/.nix
#sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
sudo nixos-rebuild switch --flake .#
popd

