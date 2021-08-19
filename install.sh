#!/bin/bash


# Install fish shell
./install_fish.sh


for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    echo "$f"
done