#!/bin/bash
stow_dirs=$(ls -d * | grep -v "\." | xargs)
stow ${stow_dirs}
sudo stow --target=/root ${stow_dirs}
