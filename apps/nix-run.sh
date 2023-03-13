package=$1
executable=${2:-$package}
nix-shell -p $package --run $executable
