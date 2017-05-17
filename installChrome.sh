#!/usr/bin/env bash

# created by: eric boxer 2015
# email: eric@ericboxer.net  
# http://ericboxer.net 

#This will install Dropbox

# Downloads file
echo "Downloading Chrome..."
curl -Lo $TST/chrome.dmg https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg

echo "Done."
echo ""
echo ""

# Unzip file to the root applications folder
echo "Opening..."
open $TST/chrome.dmg
echo ""
echo ""

# Run Dropbox installer
echo "Moving to applications..."
echo ""
echo ""
sudo cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/

# Unmounting Google DMG
echo "Unmounting Google DMG..."
echo ""
echo ""
diskutil unmount /Volumes/Google\