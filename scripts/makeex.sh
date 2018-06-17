#!/usr/bin/env bash

# Makes all files in my scripts folder executable and symlinks then as a command
# TODO: Fix like all of it. This is shit.
scriptFolder=~/dotfiles/scripts/
dotfiles=~/dotfiles/scripts/

for f in $(ls -A $scriptFolder)
do
filename=$(basename "$scriptfolder$f")
echo $filename
fname=${filename%.*}



if [ -L $scriptFolder$fname ]
then
    echo "Link $fname exists."
else
    chmod +x $scriptFolder$filename
    ln -s $scriptFolder$filename $scriptFolder$fname
fi



done
