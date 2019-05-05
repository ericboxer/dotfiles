#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

# CHANGELOG
# 20190504
# Moved from having to clone the repo to a local desitination to being able run the script from GitHub and only bring down what is truly needed. Inspiration from Homebrew... just with less Ruby.

# Set the locations to grab files from for when we need them
brewsFile="curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/brewInstalls.txt"
casksFile="curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/caskInstalls.txt"
brewFontsFile="curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/brewFontsInstalls.txt"
folders=($(curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/foldersInstalls.txt | tr -s '\n' ' '))
symlinksFile=($(curl -L https://raw.githubusercontent.com/ericboxer/dotfiles/master/symlinksInstalls.txt | tr -s '\n' ' '))


# Request admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Createing required folders..."

for i in ${folders[*]} do
  mkdir -p "$i"
done

for i in ${symlinksFile[*]} do
  curl -L "https://raw.githubusercontent.com/ericboxer/dotfiles/master/filesToSymlink/$i" >"~/.dotfiles/filesToSymlink/$i"
  ln -s "~/.dotfiles/filesToSymlink/$i" "~/$i"
done

mkdir /usr/local/include # see https://github.com/Homebrew/brew/issues/3228 for this

sudo chown -R $(whoami) $(brew --prefix)/*



# # Get all the normal dotfiles in place
echo "Creating dotfiles and symlinks..."

curl -L 

# echo ""
# source symlinks.sh
# source ~/.osx 
# source ~/.bash_profile

# # Process all my built in scripts
# echo "Doing scripty things..."
# echo ""
# source scripts/makeex.py


# Check for Homebrew
echo "Checking for homebrew..."
echo ""
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed..."
fi

echo "Tapping some other kegs"
# Add some taps...
brew tap homebrew/cask-fonts
brew tap sambadevi/powerlevel9k


# Install everything from Homebrew

echo "Importing casks"
casksToInstall=$($casksFile | tr -s '\n' ' ')
brewsToInstall=$($brewsFile | tr -s '\n' ' ')
brew install -v $brewsToInstall
brew cask install -v $casksToInstall

# Lets make ZSH pretty...
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# TODO: Is this needed anymore?
# Node does some funny things... move it over to LTS instead of Newest
# currentNode=$(grep 'node@' $brewsFile)
# brew unlink node && brew link --overwrite --force $currentNode
# node -v