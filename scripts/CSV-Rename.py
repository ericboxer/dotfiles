#!/usr/bin/env python3

import argparse
import logging
import os
import sys

'''
This script will rename all fo the files in the current working director based on a csv file
'''



# =====================
# META, yo 
# =====================

__version__ = '0.0.1'
__author__ = "Eric Boxer"


# =====================
# Parsing 
# =====================

parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", help="The CSV file that has the renameing parameters. Defaults to \"rename.csv\".", action='store')
parser.add_argument("-g", "--generate", help="generates a blank rename.csv for you to work from", action='store_true')
parser.add_argument("-i", "--ignore", help="Ignore the first (header) line.", action='store_true')
parser.add_argument("-e", "--export", help="Export missing files list to csv.", action="store_true")
parser.add_argument("-u", "--undo", help="Undo the naming.", action='store_true')
parser.add_argument("-d", "--debug", help="Print out debug info.", action='store_true')
parser.add_argument("-v", "--verbose", help="Extended printout", action='store_true')
args = parser.parse_args()

# =====================
# end Parsing 
# =====================



# =====================
# Settings 
# =====================
debug = args.debug
verbose = args.verbose

if verbose or debug:
    print(args)
# =====================
# end Settings 
# =====================


# ===============
# Decorators
# ===============
def addDebug(func):
    def func_wrapper(*args, **kwargs):
        if debug:
            print("Debug: {0}".format(func(*args, **kwargs)))
        else:
            return func(*args, **kwargs)
    return func_wrapper
# =====================
# end Decorators 
# =====================

def rename(oldName, newName):
    os.rename(str(oldName), str(newName))
    # return(f"{oldName} renamed to {newName}")

def removeQuotes(string):
    return string.replace("\"","")

@addDebug
def processCSV():

    missingFiles = []
    missingFilesFile = os.path.join(os.getcwd(), "missingFiles.csv")

    # What file are we reading from
    if args.file:
        renameFile = args.file
    else:
        renameFile = "rename.csv"


    # Does the rename file exist? If not why are we here?
    if not os.path.isfile(os.path.join(os.getcwd(), renameFile)):
        print(f"Womp womp, {renameFile} isn't here.")
        end()

    # Great. Read through the file and change names
    with open(renameFile, mode = "r") as f:
        lineNumber = 1
        for line in f:

            # Is there header? I don't really care about it.
            if lineNumber == 1 and args.ignore:
                pass
            else:
                splitLine = removeQuotes(line.strip()).split(',')
                if args.verbose or args.debug:
                    print(f"[{lineNumber}] Current line: {splitLine}")
                try:
                    # Did we make a stupid and have to change back? We can do that!
                    if args.undo:
                        firstFile = splitLine[1]
                        secondFile = splitLine[0]
                    else:
                        firstFile = splitLine[0]
                        secondFile = splitLine[1]
                    rename(os.path.join(os.getcwd(), firstFile),os.path.join(os.getcwd(), secondFile))
                    if verbose:
                        print(f"{firstFile} renamed to {secondFile}")
                # You tell me theres a file. But theres not.
                except FileNotFoundError:
                    if verbose:
                        print(f"Could not find file {firstFile}")
                    missingFiles.append(firstFile)
            lineNumber += 1

    #  If there a missing files spit them out to a file
    if len(missingFiles) == 0:
        returnMessage = f"{renameFile} processed."
    else:
        if os.path.isfile(missingFilesFile):
            os.remove(missingFilesFile)
        with open(missingFilesFile, 'w') as f:
            for line in missingFiles:
                f.write(f"{line}\n")
        returnMessage = f"{renameFile} processed with errors."
    
    # This really does anygood if you're debugging
    return returnMessage

def end():
    from sys import exit
    exit(0)


if __name__ == "__main__":
  
    processCSV()
    end()