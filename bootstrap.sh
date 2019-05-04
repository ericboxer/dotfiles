#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install a bunch of applciations used

# Set the temp storage for downloading zips and opening installers

brewsFile="curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/brewInstalls.txt"
casksFile="curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/caskInstalls.txt"
brewFontsFile="curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/brewFontsInstalls.txt"

# Request admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Createing required folders..."


mkdir /usr/local/include # see https://github.com/Homebrew/brew/issues/3228 for this




sudo chown -R $(whoami) $(brew --prefix)/*


# # Get all the normal dotfiles in place
echo "Creating dotfiles and symlinks..."
# echo ""
# source symlinks.sh
# source ~/.osx 
# source ~/.bash_profile

# # Process all my built in scripts
# echo "Doing scripty things..."
# echo ""
# source scripts/makeex.py

# Maker usr/local writeable 
# sudo chown -R $(whoami):admin /usr/local


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
# echo "updating Homebrew..."
# echo""
# brew update

# Install everything from Homebrew
# Not using this anymore as 

echo "Importing casks"
casksToInstall=$($casksFile | tr -s '\n' ' ')
brewsToInstall=$($brewsFile | tr -s '\n' ' ')
brew install -v $brewsToInstall
brew cask install -v $casksToInstall

brew tap homebrew/cask-fonts

# Node does some funny things... move it over to LTS instead of Newest
# currentNode=$(grep 'node@' $brewsFile)
# brew unlink node && brew link --overwrite --force $currentNode
# node -v