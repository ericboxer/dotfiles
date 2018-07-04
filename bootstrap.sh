#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install a bunch of applciations used

# Set the temp storage for downloading zips and opening installers

brewsFile="brewInstalls.txt"
casksFile="caskInstalls.txt"

# Request admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# # Get all the normal dotfiles in place
# echo "Creating dotfiles and symlinks..."
# echo ""
# source symlinks.sh
source ~/.osx 
source ~/.bash_profile

# # Process all my built in scripts
# echo "Doing scripty things..."
# echo ""
# source scripts/makeex.py

# Maker usr/local writeable
sudo chown -R $(whoami):admin /usr/local


# Check for Homebrew,
echo "Checking for homebrew..."
echo ""
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed..."
fi

# Update homebrew recipes
echo "updating Homebrew..."
echo""
brew update

# Install everything from Homebrew
casksToInstall=$(cat $casksFile | tr -s '\n' ' ')
brewsToInstall=$(cat $brewsFile | tr -s '\n' ' ')
brew cask install $casksToInstall
brew install -v $brewsToInstall


# Node does some funny things... move it over to LTS instead of Newest
currentNode=$(grep 'node@' $brewsFile)
brew unlink node && brew link --overwrite --force $currentNode
node -v

# Do pyenv stuffs
updatePyenv
