#!/usr/bin/env python3.6
import argparse
import os
import stat
import sys

# =====================
# Meta, Yo 
# =====================
__version__ = '0.0.1'
__author__ = "Eric Boxer"



# =====================
# Arguments! 
# =====================
parser = argparse.ArgumentParser()
parser.add_argument('-f','--files', nargs = '*', action = 'append' )
args = parser.parse_args()

# =====================
# Constants!
# =====================
makeEXE = stat.S_IRWXU # | stat.S_IRWXO | stat.S_IRWXU
# TODO: Add accesabilty for non *NIX machines
scriptDirectory = os.path.expanduser('~/dotfiles/scripts')

print(scriptDirectory)

# grats 

# =====================
# Functions! 
# =====================
def makeExecutable(file):
    try:
        os.chmod(file, makeEXE)
    except Exception as e:
        print(e)

def makeSymlink(file):
    try:
        expandedFile = os.path.join(scriptDirectory, file)
        filename, _ = os.path.splitext(expandedFile)
        if os.path.islink(filename) or os.path.isfile(filename):
            os.remove(filename)
            print(f"Symlink for {file} existed, removed.")
        os.link(expandedFile, filename)
        print(f"Symlink created for {file}")
    except Exception as e:
        print(e)

def addScript(file):
    makeExecutable(file)
    makeSymlink(file)

# =====================
# Main! 
# =====================

if __name__ == '__main__':

    if args.files != None:
        try:
            for l in args.files[0]:
                addScript(l)
        except Exception as e:
            print(e)
    else:
        print('no files selected')