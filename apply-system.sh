#!/bin/sh

pushd ~/.nix
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd

