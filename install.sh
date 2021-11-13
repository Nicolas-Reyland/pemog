#!/bin/bash

# Pemog installation script
# See https://github.com/Nicolas-Reyland/pemog for more info

# Setup script
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR # cd into the script dir

# Utils functions
function program_not_found {
    echo "/!\\ '$1'$2 is not installed. Exiting"
}

# Check for existence of programs
if ! command -v make &> /dev/null
then
    program_not_found "make" " (gnumake)"
    exit 1
fi
if ! command -v ghc &> /dev/null
then
    program_not_found "ghc"
    exit 1
fi
if ! command -v cabal &> /dev/null
then
    program_not_found "cabal"
    exit 1
fi

# install all the libraries
# cabal update
# cabal install regex-posix

# compiling the project
make all

# copying the templates
mkdir -p $HOME/.local/etc/pemog/
cp src/templates/*.tmpl $HOME/.local/etc/pemog/

# copying the binary file
chmod 755 pemog
mkdir -p $HOME/.local/bin
cp pemog $HOME/.local/bin/pemog
