#!/bin/bash

current_dir=$(pwd)

# The below command is gotten from this stack overflow post: https://stackoverflow.com/a/4774063
script_dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# run following find command starting from "files" located in the script directory
cd $script_dir/files
echo "Files being \"installed\" (symlinked)"

# Info for below find command, by line:
# include only files
# don't include emacs temp files
# print files being "installed" && create directories to where files should live && remove any old files manually created && symlink the files"
find -type f \
	 -not -name "*~" \
     -not -name "#*#" \
	      -exec bash -c 'file_path="$(echo ${0:2})" && dir_path="$(dirname $file_path)" && mkdir -p "$HOME/$dir_path" && echo "$HOME/$file_path" && rm -f "$HOME/$file_path" && ln -s "$(pwd)/$file_path" "$HOME/$file_path"' {} \;
cd $current_dir
