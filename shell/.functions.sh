#!/bin/bash
# some helpful functions to do commonly used stuff quicker

ERROR_CODE=1

function to() {
  local file_name="$1"
  if [ -z $file_name ]; then 
    echo -e "\e[31mFILE NAME SHOULD BE PASSED\e[0m"
    return $ERROR_CODE
  fi
  touch $file_name
  e "file_name"
}


function clear_vscode_cache() {
  rm -rf ~/Library/Application\ Support/Code/Cache/*
  rm -rf ~/Library/Application\ Support/Code/CachedData/*
}

: '
- Description:
    This function sets up new repository with everything you need. 
- Usage: 
    gi <directory-name> 
'
function gi() {
  if [[ -n "$1" ]]; then
    mkdir "$1"
    cd "$1" || exit
    git init
    touch README.md
    echo "# $1" > README.md
    touch .gitignore
    echo -e ".DS_Store" > .gitignore
  else
    echo -e "\e[31mDIRECTORY NAME SHOULD BE PASSED\e[0m"
  fi
}

: '
- Description:
    This function acts like rm command, but in safer maner (moves your files and/or directories into Trash).
- Usage: 
    t <list-of-files-and/or-directories> (also works if there are only one file/directory)
'
function t() {
  if [[ -n "$1" ]]; then
    mv "$@" ~/.Trash
  else
    echo -e "\e[31m!ERROR!\e[0m At least one file/directory name should be passed"
  fi
}

: '
- Description:
    Move to trash current folder.
'
function tc() {
  local folderName=$(pwd)
  cd ../
  t "$folderName"
}

: '
- Description:
    This function copies current directory path in clipboard.
'
function cpwd() { 
  pwd | pbcopy
}

: '
- Description:
    This function copies currently opened page in Safari URL into clipboard.
'
function cpsf() { 
  osascript -e 'tell application "Safari" to return URL of front document' | pbcopy
}

: '
- Description:
    This function creates new file and opens it in micro.
- Usage:
    cf <file1.ext> <file2.ext>...
'
function cf() {
  if [[ -n "$1" ]]; then
    touch "$@"
    micro "$@"
  else
    echo -e "\e[31m!ERROR!\e[0m File name should not be empty"
  fi
}

function mk() { 
  mkdir -p "$1" 
}

: '
- Description:
    This function creates directory and then cd into it.
- Usage:
    md <directory-name>
'
function md() {
  if [[ -n "$1" ]]; then
    mkdir -p "$1"
    cd "$1" || exit
  else
    echo -e "\e[31m!ERROR!\e[0m File name should not be empty"
  fi
}

: '
- Description:
    Create new python virtual environment and activate it
- Usage: 
    venv <optional-venv-directory-name>
'
function venv() {
  if [[ -n "$1" ]]; then
    python3 -m venv "$1"
    source "$1/bin/activate"
  else 
    python3 -m venv venv
    source "venv/bin/activate"
  fi
}
