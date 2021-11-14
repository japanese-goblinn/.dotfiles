#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BOLD="\033[1m"
PURPLE="\033[95m"
RESET="\033[0m"

ERROR_CODE=1

# -------------------------------------- UTILS -------------------------------------------

function _is_git_repo() { 
  git rev-parse --is-inside-work-tree 2>/dev/null && echo true || echo false 
}

function _print_error() { 
  echo -e "\n❌ ${BOLD}${RED}${1}${RESET}"
}

# ------------------------------------ FUNCTIONS -----------------------------------------

# show function implementation, show alias definition etc.
function wh() {
  local prog
  prog=$1
  if [ -z "$prog" ]; then
   print_error "NAME SHOULD BE PASSED"
   return $ERROR_CODE
  fi
  whence -f "$prog" | bat --language bash
}

# another tldr
function cht() { 
  local prog
  prog=$1
  if [ -z "$prog" ]; then return $ERROR_CODE; fi
  curl -s "http://cht.sh/$prog"
}

# brew. update (one or multiple) selected application(s)
function fbrup() {
  local upd
  upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $upd; do brew upgrade "$prog"; done
  fi
}

# brew. delete (one or multiple) selected application(s)
function fbrde() {
  local uninst
  uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $uninst; do brew uninstall "$prog"; done
  fi
}

# fuzzy cd
function fcd() {
  local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2>/dev/null
  local dir
  dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then return 0; fi
  cd "$dir" || return $ERROR_CODE
}

# fuzzy git log
function gl() {
  if [ "$(_is_git_repo)" = false ]; then _print_error "NOT A GIT REPO"; return $ERROR_CODE; fi
  local is_dark_theme
  is_dark_theme=$( defaults read -globalDomain AppleInterfaceStyle &>/dev/null && echo true || echo false )
  local light_option
  if [ "$is_dark_theme" = false ]; then
    light_option="--light"
  fi
  git log \
    --graph \
    --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
  | fzf \
    --ansi \
    --no-sort \
    --reverse \
    --tiebreak=index \
    --preview="f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 | delta --line-numbers $light_option; }; f {}"
}

# fzf serach env
function fenv() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}

# delta
function d() {
  local file0="$1"
  local file1="$2"
  local is_dark_theme=$( defaults read -globalDomain AppleInterfaceStyle &>/dev/null && echo true || echo false )
  local light_option=""
  if [ $is_dark_theme = false  ]; then
    light_option="--light"
  fi
  delta $light_option $file0 $file1
}

# bat
function b() {
  local file="$1"
  local theme=$( defaults read -globalDomain AppleInterfaceStyle &>/dev/null && echo $BAT_DARK_THEME || echo $BAT_LIGHT_THEME )
  bat --theme=$theme --color=always $file
}

# lazygit
function lg() {
  local config_location
  config_location="$HOME/Library/Application Support/lazygit/config.yml"
  local is_dark_theme
  is_dark_theme=$( defaults read -globalDomain AppleInterfaceStyle &>/dev/null && echo true || echo false )
  if [ "$is_dark_theme" = true ]; then
    cat "$LAZYGIT_CONFIG_PATH/dark_theme.yml" > "$config_location"
  else 
    cat "$LAZYGIT_CONFIG_PATH/light_theme.yml" > "$config_location"
  fi
  lazygit
}

# use this when airpods audio quality is broken
function fix_audio() {
  sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod
}

# use this when safari extension install returning error
function fix_safari_extensions() {
  "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister" -f "/Applications/Safari.app"
}

function set_personal_macos_defaults() {
  source "$DOTFILES_PATH/config/macos/defaults.sh"
}

# touch and edit
function to() {
  local file_name
  file_name=$1
  if [ -z "$file_name" ]; then 
    _print_error "FILE NAME SHOULD BE PASSED"
    return $ERROR_CODE
  fi
  touch "$file_name"
  e "$file_name"
}

function clear_vscode_cache() {
  rm -rf ~/Library/Application\ Support/Code/Cache/*
  rm -rf ~/Library/Application\ Support/Code/CachedData/*
}

# sets up new repository with everything you need.
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
  local folderName
  folderName=$( pwd )
  cd ../
  t "$folderName"
}

function cpwd() {  
  pwd | pbcopy
}

# copies currently opened page in Safari URL into clipboard.
function cpsf() {  
  osascript -e 'tell application "Safari" to return URL of front document' | pbcopy; 
}

function mk() {  
  mkdir -p "$1"
}

function md() {
  local dir
  dir=$1
  if [[ -n "$dir" ]]; then
    mkdir -p "$dir"
    cd "$dir" || return $ERROR_CODE
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
