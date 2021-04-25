#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

# Request admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# # Get all the normal dotfiles in place
# echo "Creating dotfiles and symlinks..."
# echo ""
source symlinks.sh
source ~/.osx 
# source ~/.bash_profile

# # Process all my built in scripts
# echo "Doing scripty things..."
# echo ""
# source scripts/makeex.py

# Maker usr/local writeable 
# sudo chown -R $(whoami):admin /usr/local
mkdir /usr/local/include # see https://github.com/Homebrew/brew/issues/3228 for this
sudo chown -R $(whoami) $(brew --prefix)/*


# Check for Homebrew,
echo "Checking for homebrew..."
echo ""
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed..."
fi

# Update homebrew recipes
echo "updating Homebrew..."
# echo""
brew update

# Install everything from Homebrew
echo "Runnng Homebrew"
brew bundle
