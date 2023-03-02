nix-store --add-fixed sha256 data/CiscoPacketTracer_820_Ubuntu_64bit.deb
export NIXPKGS_ALLOW_UNFREE=1
nix-shell -p ciscoPacketTracer8 --run packettracer8

