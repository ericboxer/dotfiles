#!/usr/bin/env bash

pyenvCompDir="$HOME/.pyenv/completions/"

# get pyenv version
pyEnvVer="$(cut -d' ' -f2 <<<"$(pyenv --version)")"

echo $pyenvCompDir

# does the virtualenv folder exist?
if [ ! -d "$pyenvCompDir" ]; then
    
    mkdir -p "$pyenvCompDir"
    echo "pyenv completions directory created"
else
    echo "pyenv completions directory already exists"

fi

cp /usr/local/Cellar/pyenv/"$pyEnvVer"/completions/pyenv.bash "$pyenvCompDir"pyenv.bash
source "$pyenvCompDir"pyenv.bash