#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install Sublime Text 3

# Downloads file
echo "Downloading Sublime Text 3..."
curl -Lo ~/Desktop/Temp/sublime.zip https://www.dropbox.com/s/w4x62p605kz1uiq/Sublime%20Text.zip?dl=0 
echo "Done."
echo ""
echo ""
echo "Copying to applications folder..."

# Unzip file to the root applications folder
unzip -nq ~/Desktop/sublime.zip -d /Applications 
echo ""
echo ""


#Deletes the zip file
# echo "Removing zip..."
# rm ~/Desktop/sublime.zip 
# echo ""
# echo ""

# Symlink the App
ln -s  "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl 

# Open Sublime Text to create defaults
echo "Opening applcaition to set defaults..."
sleep 3
open -a "Sublime Text.app"

#give it a few seconds...
echo "Give it a few seconds ..."
sleep 5


#Quite Sublime Text
echo "Quitting Sublime Text..."
osascript -e 'quit app "Sublime Text"'

# Assuming Dropbox has been installed...
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/Dropbox/Sublime/User
cd ~/dotfiles

# Create CLI call for sublime - sub
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sub


# finsihs installing Sublime Text 
echo "Finished installing Sublime Text."