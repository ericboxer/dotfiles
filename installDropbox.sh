#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install Dropbox

# Downloads file
echo "Downloading Dropbox..."
curl -Lo $TST/dropbox.zip https://www.dropbox.com/s/kk8icldkk4lu86b/Dropbox.zip?dl=0
echo "Done."
echo ""
echo ""
echo "Copying to applications folder..."

# Unzip file to the root applications folder
unzip -nq $TST/dropbox.zip -d ~/Desktop
echo ""
echo ""

# Run Dropbox installer
open -a $TST/"Dropbox.app"

# Wait for user input to continue
read -rsp $'When Dropbox installation is done press any key to continue...\n' -n1 key