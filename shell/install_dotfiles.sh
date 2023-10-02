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
  _maybe_brew_cask_install "arc" # best browser
  _maybe_brew_cask_install "raycast" # best relacement of spotlight and smol tools
  _maybe_brew_cask_install "iina" # best video player
  _maybe_brew_cask_install "telegram" # best messanger
  _maybe_brew_cask_install "warp" # best terminal 
  _maybe_brew_cask_install "fork" # best git client
  _maybe_brew_cask_install "sublime-text" # best text editor
  _maybe_brew_cask_install "airbuddy" # better airpods experience 
  _maybe_brew_cask_install "visual-studio-code" 
  _maybe_brew_cask_install "zed" # maybe a replace for sublime and powerful as vscode
  _maybe_brew_cask_install "paw" # api tool (http client and more)
  _maybe_brew_cask_install "dash" # search docks like a king
  _maybe_brew_cask_install "logseq" # my main knowledge base editor
  _maybe_brew_cask_install "spotify" # music
  _maybe_brew_cask_install "xcodes" # quick install and manage Xcode (using this not cli becouse CLI is building from source and needs xcode already installed to succeed)
  _maybe_brew_cask_install "db-browser-for-sqlite" # simple sqlite db explorer 
  _maybe_brew_cask_install "lookin" # better alternative to Xcode view debugger 
  _maybe_brew_cask_install "keyboardcleantool" # app to lock keyboard while cleanin it up
  _maybe_brew_cask_install "calibre" # e-books editor
  _maybe_brew_cask_install "licecap" # cool screen recorder to make lightweight gifs for you project and/or arcicles
  _maybe_brew_cask_install "dozer" # hide items from menu item
  _maybe_brew_cask_install "deepl" # AI translator
  _maybe_brew_cask_install "onyx" # system junk cleanup (like clean my mac but free)
  _maybe_brew_cask_install "disk-inventory-x" # show what occupies disk space with nice kinda graph
  _maybe_brew_cask_install "ilya-birman-typography-layout" # [Типографская раскладка Ильи Бирмана](https://ilyabirman.ru/typography-layout/)
  _maybe_brew_cask_install "shottr" # best screenshot tool (with color picker, text recognision and more)
  _maybe_brew_cask_install "keycastr" # keystroke visualizer
  _maybe_brew_cask_install "imageoptim" # image compressor

  # App Store 
  _mas_install "904280696"  # Things 3. Task manager
  _mas_install "1569600264" # Pandan. Time Tracking app
  _mas_install "1529448980" # Reeder. RSS client
  _mas_install "1380446739" # Injection III. Hot reload for iOS and macOS (UIKit, SwiftUI)
  _mas_install "888422857"  # Overcast. Podcast player
  _mas_install "1629008763" # Little Snitch Mini. Monitor where apps sends their requests and block suspicious one 😑
  _mas_install "1006739057" # NepTunes. last.fm scrobber

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
}

function tools_install() {
  _print_info "\nRunning tools install phase..."

  # rust
  curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh

  # xcode
  xcodes install --latest
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
    
  # color picker
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

dotfiles_install
brew_install
tools_install
configs_install

source "$HOME/.zshrc"

sudo /bin/zsh "$DOTFILES_PATH/shell/setup_sudo_touch_id.sh"
/bin/zsh "$DOTFILES_CONFIG_PATH/macos/defaults.sh"
