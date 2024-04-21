#!/usr/bin/env bash

clear
df -h | grep -E "Filesystem|^/dev/dm-1" 

echo -e "\nCLEANUP?"
read -p "Press Ctrl+C to cancel or ENTER to continue..."

echo "Press any key to continue..."

nix-collect-garbage
nix-collect-garbage -d
sudo nix-collect-garbage -d

df -h | grep "^/dev/dm--1" 
