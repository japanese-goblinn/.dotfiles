RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BOLD="\033[1m"
PURPLE="\033[95m"
RESET="\033[0m"

function _print_error() { echo -e "\n❌ ${BOLD}${RED}${1}${RESET}"; }

ERROR_CODE=1

function to() {
  local file_name="$1"
  if [ -z $file_name ]; then 
    _print_error "FILE NAME SHOULD BE PASSED"
    return $ERROR_CODE
  fi
  touch $file_name
  e "file_name"
}

function clear_vscode_cache() {
  rm -rf ~/Library/Application\ Support/Code/Cache/*
  rm -rf ~/Library/Application\ Support/Code/CachedData/*
}

# This function sets up new repository with everything you need.
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
    _print_error "DIRECTORY NAME SHOULD BE PASSED"
  fi
}

function t() {
  if [[ -n "$1" ]]; then
    mv "$@" ~/.Trash
  else
    _print_error "At least one file/directory name should be passed"
  fi
}

function tc() {
  local folderName=$(pwd)
  cd ../
  t "$folderName"
}

function cpwd() {  pwd | pbcopy; }

# copies currently opened page in Safari URL into clipboard.
function cpsf() {  osascript -e 'tell application "Safari" to return URL of front document' | pbcopy; }

function mk() {  mkdir -p "$1"; }

function md() {
  local dir="$1"
  if [[ -n $dir ]]; then
    mkdir -p $dir
    cd $dir || exit
  else
    _print_error "DIRECTORY NAME SHOULD NOT BE EMPTY"
  fi
}

function venv() {
  if [[ -n "$1" ]]; then
    python3 -m venv "$1"
    source "$1/bin/activate"
  else 
    python3 -m venv venv
    source "venv/bin/activate"
  fi
}

# brew. update (one or multiple) selected application(s)
function brup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# brew. delete (one or multiple) selected application(s)
function brde() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}
