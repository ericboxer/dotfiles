#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 


# Creates symlinks to dotfiles that need to be referenced by the system.

hd=~/
df=~/dotfiles/filesToSymlink/


for f in $(ls -A $df)
do
if [ -a $hd$f ]
then
	echo "$hd$f Exists as a file, removing."
	rm $hd$f
elif [ -L $hd$f ] 
then
	echo "$hd$f Exists as a link, removing."
	rm $hd$f
else
	echo "$hd$f Doesn't exist, creating."
fi
	ln -s $df$f $hd$f
	echo "creating $hd$f"
	echo "running $f"
done
