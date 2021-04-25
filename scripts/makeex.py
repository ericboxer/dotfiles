#!/usr/bin/env python3
import argparse
import getpass
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
# TODO: Add accesabilty for non *NIX machines
scriptDirectory = os.path.expanduser('~/dotfiles/scripts')

# =====================
# Functions! 
# =====================
def makeExecutable(file):
    try:
        fileWithFullPath = os.path.join(scriptDirectory,file)
        st = os.stat(fileWithFullPath)
        os.chown(fileWithFullPath, os.getuid(), os.getgid())
        print(f'{getpass.getuser()} has been given owership of {file}')
        os.chmod(fileWithFullPath, 0o775)
        
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

# The built isfile / islink functions suck balls.
def isFile(path):
    if os.path.splitext(path)[1] != '':
        return True
    return False

# =====================
# Main! 
# =====================

if __name__ == '__main__':

    if args.files != None:
        try:
            # map(addScript, args.files[0])
            for l in args.files[0]:
                print(f"Processing {l}")
                addScript(l)
        except Exception as e:
            print(e)
    else:
        allFiles = os.listdir(scriptDirectory)
        for f in allFiles:
            try:
                fileWithFullPath = os.path.join(scriptDirectory,f)
                if isFile(fileWithFullPath):
                    addScript(fileWithFullPath)
            except Exception as e:
                print(f, e)
                