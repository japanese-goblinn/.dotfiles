#!/bin/bash

set -e

YELLOW="\033[33m"
GREEN="\033[32m"
PURPLE="\033[95m"
RED="\033[31m"
COLOR_RESET="\033[0m"

function print_warning() { echo -e "⚠️  ${YELLOW}${1}${COLOR_RESET}"; }
function print_error() { echo -e "❌ ${RED}${1}${COLOR_RESET}"; }
function print_success() { echo -e "✅ ${GREEN}${1}${COLOR_RESET}"; }
# TODO: remove
function _get_parent_dir_abs_path() { echo "$( cd "$(dirname "$1")" && pwd )" }

function pre_scripts_install() { 
  xcode-select --install 2>/dev/null || print_warning "Xcode CLI tools already installed" 
}

function install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function brew_install() {
  /bin/bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh )" 
  
  # GUI apps
  brew install --cask raycast
  brew install --cask iterm2 
  brew install --cask visual-studio-code 
  brew install --cask iina 
  brew install --cask paw
  brew install --cask fork
  brew install --cask google-chrome 
  brew install --cask transmission
  brew install --cask telegram
  brew install --cask discord
  brew install --cask slack
  brew install --cask karabiner-elements # keyboard configuration
  
  # cli 
  brew install xxh # ssh with own dotfiles config
  brew install jq # json processor
  brew install micro # cli text editor
  brew install shellcheck # tool for static analysis of shellscript
  brew install bat # beautiful printing directly to terminal
  brew install exa # modern ls replacement
  brew install httpie # fancy curl
  brew install tldr # short intro to any command
  brew install gh # working with github from cli
  brew install coreutils # some linux utils that now available by default on macOS
  brew install gnupg # gpg
  brew install gping # ping but with graph
  brew install fzf # fuzzy search 
  $(brew --prefix)/opt/fzf/install
  brew install lazygit # better work with git from cli
  brew install tree # print tree of directories structure
  brew install thefuck # fix last command
  brew install ripgrep # better grep

  # apple
  brew install cocoapods 
  gem install xcode-install
}

function dotfiles_install() {
  export DOTFILES_PATH=$( _get_parent_dir_abs_path $0 )
  (cd $DOTFILES_PATH && git submodule update --init --recursive) 
  source "$SHELL_CONFIGS_PATH/exports.sh"
  (cd "$DOTFILES_DEPENDECIES_PATH/xcode_theme" && ./install.sh) 
  set_personal_macos_defaults
}

function configs_install() {
  # git
  ln -s "$DOTFILES_CONFIG_PATH/git/.gitconfig" ~/.gitconfig 
  
  # run crontab
  crontab "$DOTFILES_CONFIG_PATH/auto_backups/cronetab.txt" && crontab -l 
  
  # micro
  ln -s "$DOTFILES_CONFIG_PATH/micro" ~/.config/
    
  # vscode
  local VSCODE_PATH="$DOTFILES_CONFIG_PATH/vscode/"
  xargs -L1 code --install-extension < "$VSCODE_PATH/extensions.txt"
  ln -s "$VSCODE_PATH/settings.json" ~/Library/Application\ Support/Code/User/settings.json
  
  # raycast
  git clone "https://github.com/japanese-goblinn/script-commands.git"
  
  # iterm2
  print_warning "iTerm needs manual install of config"
  mk "$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch/"
  ln -s ~/.dotfiles/config/iterm/auto_dark_mode.py ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/auto_dark_mode.py
}

function keys_install() {
  # gpg key
  brew install gpg-suite && print_warning "Go and generate a new GPG key"
  # gpg --list-secret-keys --keyid-format LONG (get A3CDF698F9B37035 from this)
  # gpg --armor --export A3CDF698F9B37035
  # add to github
  
  # ssh for github
  print_warning "Go and generate SSH key in Xcode"
  # ssh-keyscan github.com >> ~/.ssh/known_hosts
}

function additional_setup() { 
  print_warning "SF Mono install needed" 
}

pre_scripts_install
brew_install
dotfiles_install
configs_install
keys_install
additional_setup
source "$HOME/.zshrc"
