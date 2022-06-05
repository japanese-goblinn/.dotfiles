# ----------------------------------- CONSTANTS ------------------------------------------

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BOLD="\033[1m"
PURPLE="\033[95m"
RESET="\033[0m"

SUCCESS_CODE="0"
ERROR_CODE="1"

# -------------------------------------- UTILS -------------------------------------------

function _print_warning() { 
  echo "${YELLOW}$1${RESET}"
}

function _print_error() { 
  echo "${RED}$1${RESET}"
}

function _print_success() { 
  echo "${GREEN}$1${RESET}"
}

function _is_git_repo() { 
  git rev-parse --is-inside-work-tree &>/dev/null && true || false 
}

function _is_macos_dark() {
  defaults read -globalDomain AppleInterfaceStyle &>/dev/null && true || false
}

function _lazygit_config() {
  local config_location
  config_location="$HOME/Library/Application Support/lazygit/config.yml"
  if _is_macos_dark; then
    cat "$LAZYGIT_CONFIG_PATH/dark_theme.yml" > "$config_location"
  else 
    cat "$LAZYGIT_CONFIG_PATH/light_theme.yml" > "$config_location"
  fi
}

function _is_installed() {
  [ `command -v "$1"` 2>/dev/null ] && true || false
}

function _is_brew_insalled() {
  local program
  program="$1"
  brew list "$program" &>/dev/null && true || false
}

function _maybe_brew_install() {
  local program
  program="$1"
  if $( _is_brew_insalled "$program" ); then
    _print_warning "'$program' already installed"
    return "$SUCCESS_CODE"
  fi
  _print_success "Installing '$program'..."
  brew install "$program" \
    && _print_success "Successfully installed '$program'" \
    || _print_error "Failed to install '$program'"
}

function _maybe_brew_cask_install() {
  local program
  program="$1"
  if $( _is_brew_insalled "$program" ); then
    _print_warning "'$program' already installed"
    return "$SUCCESS_CODE"
  fi
  # application (cask) can be installed not from 'brew' so we check that case here
  # this transforms "program-name" to "Program Name.app/"
  # not every application follows this convension so that is pretty failable 
  # for example "karabiner-elements" turns into "Karabiner-Elements.app/"
  # but because most casks do - we'll try anyway
  # capitilze name, remove `-` and add `.app/` postfix
  macos_program_name="${(C)program//-/ }.app/" 
  if [[ -d "/Applications/$macos_program_name" ]]; then
    _print_warning "'$program' already installed"
    return "$SUCCESS_CODE"
  fi
  _print_success "Installing '$program'..."
  brew install --cask "$program" \
    && _print_success "Successfully installed '$program'" \
    || _print_error "Failed to install '$program'"
}

function _mas_install() {
  local program_id
  program_id="$1"
  mas install "$program_id" || _print_error "Failed to install '$program_id'"
}

# ------------------------------------ FUNCTIONS -----------------------------------------

# opens man page in Preview.app
function manpdf() {
  man -t "$1" | open -fa "/System/Applications/Preview.app/"
}

# fuzzy kill process
function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | awk '{print $2, $8}' | fzf | awk '{print $1}')
  if [ -z "$pid" ]; then
    _print_warning "Terminated" 
    return $ERROR_CODE
  fi
  echo $pid | xargs kill -${1:-9}
}

# open current git repository remote
function gr() {
  if ! _is_git_repo; then
    _print_error 'Not a git repo'
    return $ERROR_CODE
  fi
  local repo_url
  repo_url="$(git config remote.origin.url)"
  if [ -z "$repo_url" ]; then 
    _print_error "Can't find remote"
    return $ERROR_CODE
  fi
  open "$repo_url" || _print_error "Can't open remote"
}

# show function implementation, alias definition etc.
function wh() {
  local prog
  prog="$1"
  if [ -z "$prog" ]; then
   _print_error "Name should be passed"
   return $ERROR_CODE
  fi
  whence -f "$prog" | b --plain --language bash
}

# another tldr
function cht() { 
  local prog
  prog="$1"
  if [ -z "$prog" ]; then return $ERROR_CODE; fi
  curl -s "http://cht.sh/$prog"
}

# fuzzy git log
function gl() {
  if ! _is_git_repo; then 
    _print_error "Not a git repo"
    return $ERROR_CODE 
  fi
  local light_option
  if ! _is_macos_dark; then
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

# fuzzy serach environment variables
function fenv() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}

# delta wrapper
function d() {
  local file0
  file0="$1"
  local file1
  file1="$2"
  local light_option
  if ! _is_macos_dark; then
    light_option="--light"
  fi
  delta $light_option "$file0" "$file1"
}

# lazygit wrapper
function lg() {
  _lazygit_config
  lazygit
}

# create file and edit
function to() {
  local file_name
  file_name=$1
  if [ -z "$file_name" ]; then 
    _print_error "File name should be passed"
    return $ERROR_CODE
  fi
  touch "$file_name"
  e "$file_name"
}

# move to trash every file of current direcotry
alias tca="ta ."

# move to trash every file of passed directory 
function ta() {
  local dir
  dir="$1"
  if [[ -z "$dir" ]]; then
    _print_error "No arguments passed"
    return $ERROR_CODE
  fi
  if [[ ! -d "$dir" ]]; then
    _print_error "Passed argument is not a directory"
    return $ERROR_CODE
  fi
  for file in "$dir"/*; do
    t "$file"
  done
}

# move to Trash specified files/directories/etc.
function t() {
  if [ -n "$1" ]; then
    mv "$@" ~/.Trash
  else
    _print_error "At least one file/directory name should be passed"
  fi
}

# move to Trash current direcotry
function tc() {
  local dir
  dir="$(pwd)"
  cd ../
  t "$dir"
}

# make directory and cd into
function mkcd() {
  local dir
  dir=$1
  if [ -n "$dir" ]; then
    mk "$dir"
    cd "$dir" || return $ERROR_CODE
  else
    _print_error "Directory name should not be empty"
  fi
}
