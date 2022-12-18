#!/bin/sh

pushd ~/.nix
home-manager switch -f ./users/gds/home.nix
popd

