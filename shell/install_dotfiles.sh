#!/bin/zsh

function dotfiles_install() { 
  _print_info "\nRunning dotfiles install phase..."
  
  ln -sF "$DOTFILES_PATH/.zshrc" "$HOME"
  
  (cd $DOTFILES_PATH && git submodule update --init --recursive) 
  (cd "$DOTFILES_DEPENDECIES_PATH/xcode_theme" && "./install.sh") 
}

function brew_install() {
  _print_info "\nRunning brew install phase..."
  
  if ! _is_installed "brew"; then
    /bin/bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh )" 
  fi
  
  # GUI Apps 
  _maybe_brew_cask_install "arc" # chromium browser with cool features
  _maybe_brew_cask_install "raycast" # best relacement of spotlight and smol tools
  _maybe_brew_cask_install "iina" # best video player
  _maybe_brew_cask_install "telegram" # best messanger
  _maybe_brew_cask_install "warp" # best terminal 
  _maybe_brew_cask_install "fork" # best git client
  _maybe_brew_cask_install "sublime-text" # best text editor
  _maybe_brew_cask_install "airbuddy" # better airpods experience 
  _maybe_brew_cask_install "zed" # maybe a replace for sublime and powerful as vscode
  _maybe_brew_cask_install "paw" # api tool (http client and more)
  _maybe_brew_cask_install "dash" # search docks like a king
  _maybe_brew_cask_install "spotify" # music
  _maybe_brew_cask_install "xcodes" # quick install and manage Xcode (using this not cli becouse CLI is building from source and needs xcode already installed to succeed)
  _maybe_brew_cask_install "db-browser-for-sqlite" # simple sqlite db explorer 
  _maybe_brew_cask_install "keyboardcleantool" # app to lock keyboard while cleanin it up
  _maybe_brew_cask_install "calibre" # e-books editor
  _maybe_brew_cask_install "licecap" # cool screen recorder to make lightweight gifs for you project and/or arcicles
  _maybe_brew_cask_install "dozer" # hide items from menu item
  _maybe_brew_cask_install "deepl" # AI translator
  _maybe_brew_cask_install "onyx" # system junk cleanup (like clean my mac but free)
  _maybe_brew_cask_install "disk-inventory-x" # show what occupies disk space with nice kinda graph
  _maybe_brew_cask_install "shottr" # best screenshot tool (with color picker, text recognision and more)
  _maybe_brew_cask_install "keycastr" # keystroke visualizer
  _maybe_brew_cask_install "imageoptim" # image compressor
  _maybe_brew_cask_install "nota" # knowlege base notes
  _maybe_brew_cask_install "contexts" # window switcher
  _maybe_brew_cask_install "the-unarchiver" 
  _maybe_brew_cask_install "aldente" # supports battery health
  _maybe_brew_cask_install "lulu" # Firewall to block unknown outgoing connections
  _maybe_brew_cask_install "tempbox" # app to create temprorary disposable emails
  _maybe_brew_cask_install "fantastical" # calendar app 

  # Command Line Utils
  _maybe_brew_install "mas" # download apps from app store 
  _maybe_brew_install "ripgrep" # better grep
  _maybe_brew_install "fd" # better find
  _maybe_brew_install "tealdeer" # better tldr
  _maybe_brew_install "bat" # beautiful printing directly to terminal
  _maybe_brew_install "exa" # modern ls replacement
  _maybe_brew_install "httpie" # fancy curl
  _maybe_brew_install "coreutils" # some linux utils that now available by default on macOS
  _maybe_brew_install "gnupg" # gpg
  _maybe_brew_install "fzf" && $(brew --prefix)/opt/fzf/install # fuzzy search 
  _maybe_brew_install "tree" # print tree of directories structure
  _maybe_brew_install "git-delta" # syntax-highlighting pager for git, diff, and grep output
  _maybe_brew_install "zoxide" # better cd https://github.com/ajeetdsouza/zoxide
  _maybe_brew_install "jid" # interactive jq (tool to process JSON)
  _maybe_brew_install "ffmpeg" # video processing tool

  _maybe_brew_cask_install "karabiner-elements" # remap your keyboard
  _maybe_brew_install "yqrashawn/goku/goku" # DSL for karabiner

  _maybe_brew_install "blackhole-2ch" # virtual audio channel. redirect simulator audio ouput here to get rid of speaker cracking on playing audio while running something of simulator
  _maybe_brew_cask_install "lychee" # tool to find broken URL’s in document

    # App Store 
  _mas_install "904280696"  # Things 3. Task manager
  _mas_install "1529448980" # Reeder. RSS client
  _mas_install "1380446739" # Injection III. Hot reload for iOS and macOS (UIKit, SwiftUI)
  _mas_install "1006739057" # NepTunes. last.fm scrobber
  _mas_install "405399194" # Kindle App
  _mas_install "963034692" # Streaks. Habbit’s tracker app
  _mas_install "1423210932" # Flow. Pomodoro app
  _mas_install "1629008763" # Little Snitch. Network traffic monitor
  
  _mas_install "1030595027" # Wipr. Safari ads blocker
  _mas_install "1432182561" # Cascadea. Safari custom CSS
}

function tools_install() {
  _print_info "\nRunning tools install phase..."

  # rust
  curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
}

function configs_install() {
  _print_info "\nRunning configs install phase..."
  
  # git
  (cd "$DOTFILES_CONFIG_PATH/git" && touch ".github_token" && echo -e "[user]\n\ttoken = " > .github_token)
  _print_warning "GitHub Token setup needed"
  ln -sF "$DOTFILES_CONFIG_PATH/git/.gitconfig" "$HOME/.gitconfig" 
  ln -sF "$DOTFILES_CONFIG_PATH/git/.github_token" "$HOME/.github_token"
  ln -sF "$DOTFILES_CONFIG_PATH/git/.gitignore" "$HOME/.gitignore" 
  
  # run crontab
  crontab "$DOTFILES_CONFIG_PATH/auto_backups/crontab.txt" && crontab -l 
      
  # vscode
  local VSCODE_PATH="$DOTFILES_CONFIG_PATH/vscode/"
  xargs -L1 code --install-extension < "$VSCODE_PATH/extensions.txt"
  ln -sF "$VSCODE_PATH/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
  ln -sF "$VSCODE_PATH/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
    
  # color pickerw
  cp "$DOTFILES_CONFIG_PATH/color_picker/Color Picker.app" "/Applications"

  # sublime 
  ln -sF "$DOTFILES_CONFIG_PATH/sublime/sublime-profiles/" "$HOME/Library/Application Support/Sublime Text/Packages/"
  ln -sF "$DOTFILES_CONFIG_PATH/sublime/User" "$HOME/Library/Application Support/Sublime Text/Packages/"

  # tealdear
  tldr --seed-config
  ln -sF "$DOTFILES_CONFIG_PATH/tealdeer/config.toml" "$HOME/Library/Application Support/tealdeer/"

  # system keys ramapping (applies after restart)
  ln -sF "$DOTFILES_CONFIG_PATH/macos/com.local.KeyRemapping.plist" "$HOME/Library/LaunchAgents/"

  # warp
  ln -sF "$DOTFILES_CONFIG_PATH/.warp" "$HOME/.warp"
}

function additional_setup() { 
  _print_info "\nRunning additional setup phase..."
  
  _print_warning "'SF Mono' install needed" 
  _print_warning "'raycast config' import needed"
  _print_warning "Settings -> Trackpad -> More Gestures -> App Exposé"
  _print_warning "Settings -> Keyboard -> Shortcuts -> Mission Control -> Disable 'Move left/right a space'"
  _print_warning "Settings -> Keyboard -> Shortcuts -> Input Sources -> Change to shortuct from karabiner config"
  _print_warning "Install Universal Layout https://github.com/tonsky/Universal-Layout/releases"
  _print_warning "Install Inteli Bar https://github.com/intellibar/main/releases"

  # Generate ssh key
  (
    mkdir -p ~/.ssh && cd "$_" \
      && ssh-keygen -t ecdsa -C "cool45akol@gmail.com" \
      && cat id_ecdsa.pub | pbcopy \
      && _print_warning "Go to https://github.com/settings/keys and register SSH key from pasteboard"
  )
}

export DOTFILES_PATH="$( cd "$(dirname "$0")/"../ && pwd )"
source "$DOTFILES_PATH/shell/exports.sh"
source "$DOTFILES_PATH/shell/functions.sh"

dotfiles_install
brew_install
tools_install
configs_install
additional_setup

source "$HOME/.zshrc"

sudo /bin/zsh "$DOTFILES_PATH/shell/setup_sudo_touch_id.sh"
/bin/zsh "$DOTFILES_CONFIG_PATH/macos/defaults.sh"
