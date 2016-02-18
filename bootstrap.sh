#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install a bunch of applciations used

# Set the temp storage for downloading zips and opening installers

TST=~/Desktop/Temp

mkdir $TST

# Request admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Installing Dropbox
Echo "Installing Dropbox [required]..."
source installDropbox.sh


echo "Creating dotfiles and symlinks..."
echo ""
source symlinks.sh

# Maker usr/local writeable
sudo chown -R $(whoami):admin /usr/local

echo "Installing CocoaPods..."
echo ""
source installCocoaPods.sh

# Check for Homebrew,
echo "Checking for homebrew..."
echo ""
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "updating Homebrew..."
echo""
brew update

#install some fun items
echo "installing wget..."
brew install wget

# Install Ruby
echo "installing ruby..."
brew install ruby

# Update the gems...
echo "Updating Ruby..."
gem update --systems

# install Node.js
echo "installing Node.js"
brew install node 

# Install Sublime Text
read -p "Install Sublime Text? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    source installSublime.sh
fi


#Delete Temp storage folder on the desktop
rm -r $TST
