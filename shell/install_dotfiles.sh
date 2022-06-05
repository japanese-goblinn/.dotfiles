#!/bin/zsh

function dotfiles_install() { 
  _print_info "\nRunning dotfiles install phase..."
  
  ln -sF "$DOTFILES_PATH/.zshrc" "$HOME"
  
  (cd $DOTFILES_PATH && git submodule update --init --recursive) 
  
  (cd "$DOTFILES_DEPENDECIES_PATH/xcode_theme" && ./install.sh) 
  
  # TODO: run run config scripts (like setup_sudo*.sh)
  (cd "$DOTFILES_PATH/config/git" && touch ".github_token" && echo -e "[user]\n\ttoken = " > .github_token)
  _print_warning "GitHub Token setup needed"
}

function brew_install() {
  _print_info "\nRunning brew install phase..."
  if $( ! _is_installed "brew" ); then
    /bin/bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh )" 
  fi
  
  # GUI apps
  _maybe_brew_cask_install "firefox" # primary browser 
  _maybe_brew_cask_install "raycast" # best relacement of spotlight and smol tools
  _maybe_brew_cask_install "iina" # best video player
  _maybe_brew_cask_install "telegram" # best messanger
  _maybe_brew_cask_install "airbuddy" # better airpods experience 
  _maybe_brew_cask_install "iterm2" # best terminal 
  _maybe_brew_cask_install "fork" # amazing git client
  _maybe_brew_cask_install "sublime-text" # amazing text editor
  _maybe_brew_cask_install "sublime-merge" # another amazing git client
  _maybe_brew_cask_install "visual-studio-code" 
  _maybe_brew_cask_install "paw" # api tool (http client and more)
  _maybe_brew_cask_install "transmission" # torrent client 
  _maybe_brew_cask_install "discord"
  _maybe_brew_cask_install "slack"
  _maybe_brew_cask_install "dash" # search docks like a king
  _maybe_brew_cask_install "obsidian" # knowledge base editor
  _maybe_brew_cask_install "spotify" # music
  _maybe_brew_cask_install "netnewswire" # Nice open-source RSS client for macOS/iOS

  # cli 
  _maybe_brew_install "mas" # download apps from app store 
  _maybe_brew_install "ripgrep" # better grep
  _maybe_brew_install "fd" # better find
  _maybe_brew_install "tealdeer" # better tldr
  _maybe_brew_install "jq" # json processor
  _maybe_brew_install "shellcheck" # tool for static analysis of shellscript
  _maybe_brew_install "bat" # beautiful printing directly to terminal
  _maybe_brew_install "exa" # modern ls replacement
  _maybe_brew_install "httpie" # fancy curl
  _maybe_brew_install "gh" # working with github from cli
  _maybe_brew_install "coreutils" # some linux utils that now available by default on macOS
  _maybe_brew_install "gnupg" # gpg
  _maybe_brew_install "fzf" && $(brew --prefix)/opt/fzf/install # fuzzy search 
  _maybe_brew_install "lazygit" # better work with git from cli
  _maybe_brew_install "tree" # print tree of directories structure
  _maybe_brew_install "git-delta" # syntax-highlighting pager for git, diff, and grep output

  # App Store 
  _mas_install "1569600264" # Pandan. Time Tracking app
}

function configs_install() {
  _print_info "\nRunning configs install phase..."
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
  curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh

  # lazygit
  _lazygit_config
}

function additional_setup() { 
  _print_info "\nRunning additional setup phase..."
  _print_warning "'SF Mono' install needed" 
  _print_warning "'raycast config' import needed"

  # TODO: Write script to automaticly upload ssh key
  # https://github.com/TheArqsz/auto-ssh-key
  # Generate ssh key
  (
    cd ~/.ssh \
      && ssh-keygen -t ecdsa -C "cool45akol@gmail.com" \
      && cat id_ecdsa.pub | pbcopy \
      && _print_warning "Go to https://github.com/settings/keys and register SSH key from pasteboard"
  )
}

export DOTFILES_PATH="$( cd "$(dirname "$0")/"../ && pwd )"
source "$DOTFILES_PATH/shell/exports.sh"
source "$DOTFILES_PATH/shell/functions.sh"

xcode-select --install 2>/dev/null || _print_warning "Xcode CLI tools already installed"
dotfiles_install
brew_install
configs_install
source "$HOME/.zshrc"
source "$DOTFILES_PATH/config/macos/defaults.sh"
