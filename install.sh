#!/bin/bash

current_dir=$(pwd)
source_dir=$(dirname -- "$0";)

cd $source_dir
echo "Files being \"installed\" (symlinked)"

# Info for below find command, by line:
# include only files
# don't include emacs temp files
# don't include install script
# don't include .gitignore file
# don't include git directory
# print files being "installed" && create directories if missing && remove any old files manually created && symlink the files"
find .* -type f \
	 -not -name "*~" \
	 -not -name "install.sh" \
	 -not -name ".gitignore" \
	 -not -path ".git/*" \
		  -exec sh -c 'echo "$HOME/$0" && mkdir -p "$HOME/{0%/*}" && rm "$HOME/$0" && ln -s "$(pwd)/$0" "$HOME/$0"' {} \;
cd $current_dir
