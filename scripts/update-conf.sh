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

# default search dirs
SEARCH_DIR=$HOME/.config
REPO_DIR=$(pwd)/config

#terminal input
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)

# opt flags
ALL=0
ADD=0
DELETE=0
FORCE=0
NO_TOUCH=0

# parse arguments
PARSED_ARGUMENTS=$(getopt -n conf-update -o Aafh --long add,force,help,no-touch -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while true; do
    case "$1" in
      # -A | --all)         ALL=1       ; shift ;;
        -a | --add)         ADD=1       ; shift ;;
      # -d | --delete)      DELETE=1    ; shift ;;
        -f | --force)       FORCE=1     ; shift ;;
        -h | --help)                      usage ;;
             --no-touch)    NO_TOUCH=1  ; shift ;;
             --)            shift       ; break ;;
             *)                           usage ;;
    esac
done

# print destination directory
# Args:
#   1: dest dir
function print_dest () {
    echo "$BOLD-- Copying to $1 --$NORMAL"
}

# loop through repo directories, find coresponding directories
# in user's config directory, then copy
# Args:
#   1: dest dir
#   2: src dir
function copy_new_files () {
    # list directories in repo and remove the cwd
    local DIRS=$(find_files $1)
    print_dest $1
    for file in $DIRS; do
        # check if a file exists, if it is newer than the
        # first file, and if it is different, then copy
        if [[ -f $2/$file && $2/$file -nt $1/$file && $(diff $1/$file $2/$file) ]]; then
            $COPY_CMD $1 $2 $file
        fi
    done
    echo "$BOLD$GREEN::$NORMAL All files in $1 are up to date."
}

# prompt user to copy, ignore, or display diff for a file
# Args:
#   1: dest dir
#   2: src dir
function ask_copy () {
    # loop until user answers yes or no, default answer is yes
    local ANSWERED=0
    while [[ $ANSWERED != 1 ]]; do
        read -p "$BOLD::$NORMAL Copy $2/$3? [Y/n/(d)iff]: " answer
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
                if [[ -f $1/$3 ]]; then
                    echo "$1/$3"
                    eval "diff --color=always -u $1/$3 $2/$3 | less -FRrSX"
                else
                    less -FRrSX $2/$3
                fi
                ;;
            *)
                echo "$BOLD$RED::$NORMAL Invalid option"
                ;;
        esac
    done
}

function add_files () {
    local NEW_FILES=$(cmp_dirs $2 $1)
    for file in $NEW_FILES; do
        ask_copy $1 $2 $file
    done
    echo "$BOLD$GREEN::$NORMAL All files in $1 are up to date."
}

# generate list of file present in dir 1 that are not present in
# dir 2
# Args:
#   1: dir 1
#   2: dir 2
function cmp_dirs () {
    local CONFIG_DIRS=$(find_dirs $REPO_DIR)
    local U_FILES=""
    for dir in $CONFIG_DIRS; do
        if [ -d $1/$dir ]; then
            local FILES="$(eval "find $1/$dir -maxdepth 1 -type f | sed -n 's|^$1/||p'")"
            for file in $FILES; do
                if [[ ! -f $2/$file ]]; then
                    U_FILES="$U_FILES $file"
                fi
            done
        fi
    done

    echo $U_FILES
}

# find files in a given directory
# Args:
#   1: search dir
function find_files () {
    local DIRS=$(eval "find $1/ | sed -n 's|^$1/||p'")
    echo $DIRS
}

# find directory in a given directory
# Args:
#   1: search dir
function find_dirs () {
    local DIRS=$(eval "find $1/ -type d | sed -n 's|^$1/||p'")
    echo $DIRS
}

# copy files without prompting
# Args:
#   1: dest dir
#   2: src dir
#   3: filename
function cp_file () {
    print_dest $1
    cp $2/$3 $1/$3
}

COPY_CMD=ask_copy
if [[ $FORCE = 1 ]]; then
    COPY_CMD=cp_file
fi

copy_new_files $REPO_DIR $SEARCH_DIR

# if [[ $DELETE = 1 ]]; then
#     echo DELETE
# fi

if [[ $ADD = 1 ]]; then
    echo "$BOLD-- Detecting new files--$NORMAL"
    add_files $REPO_DIR $SEARCH_DIR
fi
