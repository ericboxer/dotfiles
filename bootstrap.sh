#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install a bunch of applciations used


# Request admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Creating dotfiles and symlinks..."
echo ""
source symlinks.sh


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