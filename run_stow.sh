#!/bin/bash
stow_dirs=$(ls -d * | grep -v "\." | xargs)
stow ${stow_dirs}
if [[ "$OSTYPE" == "darwin"* ]]; then
  sudo stow --target=/var/root ${stow_dirs}
else
  sudo stow --target=/root ${stow_dirs}
fi
