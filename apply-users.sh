#!/bin/sh

pushd ~/.nix

#home-manager switch -f ./users/gds/home.nix

nix build .#homeManagerConfigurations.gds.activationPackage
sudo ./result/activate

popd

