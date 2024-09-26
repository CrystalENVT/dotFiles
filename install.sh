#!/bin/bash

current_dir=$(pwd)
script_dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# run following find command starting from "files" located in the script directory
cd $script_dir/files
echo "Files being \"installed\" (symlinked)"

# Info for below find command, by line:
# include only files
# don't include emacs temp files
# print files being "installed" && remove any old files manually created && symlink the files"
find -type f \
     -not -name "*~" \
     -not -name "\#*\#" \
		  -exec bash -c 'file_path="$(echo ${0:2})" && echo "$HOME/$file_path" && rm -f "$HOME/$file_path" && ln -s "$(pwd)/$file_path" "$HOME/$file_path"' {} \;
cd $current_dir
