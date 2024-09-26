#!/bin/bash

current_dir=$(pwd)
script_dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $script_dir
echo "Files being \"installed\" (symlinked)"

# Info for below find command, by line:
# include only files
# don't include emacs temp files
# don't include install script
# don't include .gitignore file
# don't include git directory
# print files being "installed" && remove any old files manually created && symlink the files"
find .* -type f \
	 -not -name "*~" \
	 -not -name "install.sh" \
	 -not -name ".gitignore" \
	 -not -path ".git/*" \
		  -exec bash -c 'echo "$HOME/$0" && rm -f "$HOME/$0" && ln -s "$(pwd)/$0" "$HOME/$0"' {} \;
cd $current_dir
