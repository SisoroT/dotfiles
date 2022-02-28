#!/bin/bash

# usage message
function usage () {
    echo "Usage: $0 [options]
         -h | --help            display this message
         -a | --all             search all directories in the repo
         -f | --force           do not ask for confirmation
              --no-touch        do not touch file when selecting \"No\""
    exit 2
}

# opt flags
ALL=0
FORCE=0
NO_TOUCH=0

# parse arguments
PARSED_ARGUMENTS=$(getopt -n conf-update -o afh --long all,force,help,no-touch -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while true; do
    case "$1" in
        -a | --all)         ALL=1       ; shift ;;
        -f | --force)       FORCE=1     ; shift ;;
        -h | --help)                      usage ;;
             --no-touch)    NO_TOUCH=1  ; shift ;;
             --)            shift       ; break ;;
             *)                           usage ;;
    esac
done

function print_dest () {
    echo "$(tput bold)-- Copying to $1 --$(tput sgr0)"
}

function copy_new_files () {
    # list directories in repo and remove the cwd
    local DIRS=$(eval "find $1/* | sed -n 's|^$1/||p'")
    for file in $DIRS; do
        # check if a file exists, if it is newer than the
        # first file, and if it is different, then copy
        if [[ -f $2/$file && $2/$file -nt $1/$file && $(diff $1/$file $2/$file) ]]; then
            $COPY_CMD $1 $2 $file
        fi
    done
    echo "$(tput bold setaf 2)::$(tput sgr0) All files in $1 are up to date."
}

function ask_copy () {
    # loop until user answers yes or no, default answer is yes
    local ANSWERED=0
    print_dest $1
    while [[ $ANSWERED != 1 ]]; do
        read -p "$(tput bold)::$(tput sgr0) Copy $2/$3? [Y/n/(d)iff]: " answer
        case $answer in
            [Yy][Ee][Ss]|[Yy]|"")
                ANSWERED=1
                cp $2/$3 $1/$3
                ;;
            [Nn][Oo]|[Nn])
                ANSWERED=1
                if [[ $NO_TOUCH = 1 ]]; then
                    continue
                fi
                touch $1/$3
                ;;
            [Dd][Ii][Ff][Ff]|[Dd])
                eval "diff --color=always -u $1/$3 $2/$3 | less -FRrSX"
                ;;
            *)
                echo "$(tput bold setaf 1)::$(tput sgr0) Invalid option"
                ;;
        esac
    done
}

function cp_file () {
    print_dest $1
    cp $2/$3 $1/$3
}

# default search dirs
SEARCH_DIR=$HOME/.config
COPY_DIR=$(pwd)/.config

COPY_CMD=ask_copy
if [[ $FORCE = 1 ]]; then
    COPY_CMD=cp_file
fi

copy_new_files $COPY_DIR $SEARCH_DIR
