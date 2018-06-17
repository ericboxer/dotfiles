#!/usr/bin/env python3

import argparse
import logging
import os
import sys
# import threading

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

    if args.file:
        renameFile = args.file
    else:
        renameFile = "rename.csv"

    with open(renameFile, mode = "r") as f:

        lineNumber = 1
        for line in f:
            if lineNumber == 1 and args.ignore:
                line.strip()
            else:
                splitLine = removeQuotes(line.strip()).split(',')
                if args.verbose or args.debug:
                    print(f"[{lineNumber}] Current line: {splitLine}")
                try:
                    if args.undo:
                        firstFile = splitLine[1]
                        secondFile = splitLine[0]
                    else:
                        firstFile = splitLine[0]
                        secondFile = splitLine[1]
                    rename(os.path.join(os.getcwd(), firstFile),os.path.join(os.getcwd(), secondFile))
                    if verbose:
                        print(f"{firstFile} renamed to {secondFile}")
                except FileNotFoundError:
                    if verbose:
                        print(f"Could not find file {firstFile}")
                    missingFiles.append(firstFile)
            lineNumber += 1
    print(missingFiles)


    if len(missingFiles) == 0:
        returnMessage = f"{renameFile} processed."
    else:
        if os.path.isfile(missingFilesFile):
            os.remove(missingFilesFile)
        with open(missingFilesFile, 'w') as f:
            for line in missingFiles:
                f.write(f"{line}\n")
        returnMessage = f"{renameFile} processed with errors."
    return returnMessage

def end():
    from sys import exit
    exit(0)


if __name__ == "__main__":
  
    processCSV()
    end()