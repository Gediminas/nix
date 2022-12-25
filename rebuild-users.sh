#!/bin/sh

set +x

ACTION=$1

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
home-manager --flake ".#gds" ${ACTION}

# DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
# nix build "${DIR}/.#homeManagerConfigurations.gds.activationPackage"
# "${DIR}/result/activate"

#pushd ~/.nix
##home-manager switch -f ./users/gds/home.nix
#nix build .#homeManagerConfigurations.gds.activationPackage
#sudo ./result/activate
#popd

