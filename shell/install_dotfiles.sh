#!/bin/bash

function _pre_scripts_install() { 
  xcode-select --install 2> /dev/null || _print_warning "Xcode CLI tools already installed"
}

function _install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function _is_installed() {
  [ `command -v "$1"` 2>/dev/null ] && echo true || echo false
}

function _brew_install() {
  if $( ! _is_installed "brew" ); then
    /bin/bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh )" 
  fi
  
  # GUI apps
  brew install --cask firefox # primary browser 
  brew install --cask raycast # best relacement of spotlight and smol tools
  brew install --cask iina # best video player
  brew install --cask telegram # best messanger
  brew install --cask airbuddy # better airpods experience 
  brew install --cask iterm2 # best terminal 
  brew install --cask fork # amazing git client
  brew install --cask sublime-text # amazing text editor
  brew install --cask sublime-merge # another amazing git client
  brew install --cask visual-studio-code 
  brew install --cask paw # api tool (http client and more)
  brew install --cask transmission # torrent client 
  brew install --cask discord
  brew install --cask slack
  brew install --cask dash # search docks like a king
  brew install --cask obsidian # knowledge base editor
  brew install --cask spotify # music
  brew install --cask karabiner-elements # keyboard keys remapper
  brew install --cask netnewswire # Nice open-source RSS client for macOS/iOS

  # cli 
  brew install ripgrep # better grep
  brew install fd # better find
  brew install jq # json processor
  brew install shellcheck # tool for static analysis of shellscript
  brew install bat # beautiful printing directly to terminal
  brew install exa # modern ls replacement
  brew install httpie # fancy curl
  brew install tldr # short intro to any command
  brew install gh # working with github from cli
  brew install coreutils # some linux utils that now available by default on macOS
  brew install gnupg # gpg
  brew install fzf # fuzzy search 
  $(brew --prefix)/opt/fzf/install
  brew install lazygit # better work with git from cli
  brew install tree # print tree of directories structure
  brew install git-delta # syntax-highlighting pager for git, diff, and grep output
  brew install fig # autocomplete tool

  # apple
  brew install cocoapods 
  gem install xcode-install
}

function _dotfiles_install() {
  export DOTFILES_PATH="$( cd "$(dirname "$0")" && pwd )"
  (cd $DOTFILES_PATH && git submodule update --init --recursive) 
  
  source "$DOTFILES_PATH/shell/exports.sh"
  source "$DOTFILES_PATH/shell/functions.sh"
  
  ln -sF "$DOTFILES_PATH/.zshrc" "$HOME"
  
  (cd "$DOTFILES_DEPENDECIES_PATH/xcode_theme" && ./install.sh) 
  
  source "$DOTFILES_PATH/config/macos/defaults.sh"
  
  # TODO: run run config scripts (like setup_sudo*.sh)
  (cd "$DOTFILES_PATH/config/git" && touch ".github_token" && echo -e "[user]\n\ttoken = " > .github_token)
  _print_warning "GitHub Token setup needed"
}

function _configs_install() {
  # git
  ln -sF "$DOTFILES_CONFIG_PATH/git/.gitconfig" ~/.gitconfig 
  ln -sF "$DOTFILES_CONFIG_PATH/git/.github_token" ~/.github_token 
  ln -sF "$DOTFILES_CONFIG_PATH/git/.gitignore" ~/.gitignore 
  
  # run crontab
  crontab "$DOTFILES_CONFIG_PATH/auto_backups/crontab.txt" && crontab -l 
      
  # vscode
  local VSCODE_PATH="$DOTFILES_CONFIG_PATH/vscode/"
  xargs -L1 code --install-extension < "$VSCODE_PATH/extensions.txt"
  ln -sF "$VSCODE_PATH/settings.json" ~/Library/Application\ Support/Code/User/settings.json
  ln -sF "$VSCODE_PATH/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
    
  # iterm2
  _print_warning "iTerm needs manual install of config"
  mk "$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch/"
  ln -sF "$DOTFILES_CONFIG_PATH/iterm/auto_dark_mode.py" ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/auto_dark_mode.py

  # color picker
  cp "$DOTFILES_CONFIG_PATH/color_picker/Color Picker.app" "/Applications"

  # sublime 
  ln -sF "$DOTFILES_CONFIG_PATH/sublime/sublime-profiles/" "$HOME/Library/Application Support/Sublime Text/Packages/"
  ln -sF "$DOTFILES_CONFIG_PATH/sublime/User" "$HOME/Library/Application Support/Sublime Text/Packages/"

  # sublime merge
  _print_success "Installing CLI tool of Sublime Merge..."
  sudo ln -sF "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" "/usr/local/bin"

  # rust
  _install_rust

  # lazygit
  _lazygit_config
}

function _additional_setup() { 
  _print_warning "SF Mono install needed" 
  _print_warning "Raycast config needed"

  # TODO: Write script to automaticly upload ssh key
  # https://github.com/TheArqsz/auto-ssh-key
  # Generate ssh key
  (
    cd ~/.ssh && \
    ssh-keygen -t ecdsa -C "cool45akol@gmail.com" && \
    cat id_ecdsa.pub | pbcopy && \
    _print_warning "Go to https://github.com/settings/keys and register SSH key from pastboard"
  )
}

_pre_scripts_install
_brew_install
_dotfiles_install
_configs_install
_additional_setup
source "$HOME/.zshrc"
