#!/bin/bash

set -ex

mv ./dotfiles-plus-plus/ ~/.dotfiles/ 
(cd ~/.dotfiles/ && git submodule update --init --recursive) 
ln -s ~/.dotfiles/zsh/.zshrc.zsh ~/.zshrc 

# cli tools
xcode-select --install

# git
ln -s ~/.dotfiles/config/git/.gitconfig ~/.gitconfig 

# crontab
crontab ~/.dotfiles/config/cronetab/cronetab.txt && crontab -l 

# brew 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

brew install iterm2 
brew install visual-studio-code 
brew install iina 
brew install paw 
brew install figma 
brew install fork 
brew install google-chrome 

brew install bat 
brew install httpie 
brew install tldr 
brew install hub 

# ios
brew install cocoapods 
(cd ~/.dotfiles/config/xcode/xcode-github-theme/ && ./install.sh)   

brew install --cask transmission

# install jetbrains-mono font
brew tap homebrew/cask-fonts 
brew install --cask font-jetbrains-mono

# micro 
brew install micro 
ln -s ~/.dotfiles/config/micro ~/.config/ 

# vscode
xargs -L1 code --install-extension < ~/.dotfiles/config/vscode/extensions.txt
ln -s ~/.dotfiles/config/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# raycast
git clone "https://github.com/japanese-goblinn/script-commands.git"

# iterm2
echo "iTerm needs manual install of config"
ln -s ~/.dotfiles/config/iterm/auto_dark_mode.py ~/Library/ApplicationSupport/iTerm2/Scripts/auto_dark_mode.py

# gpg key
brew install gpg-suite && echo "Go and generate a new GPG key"
# gpg --list-secret-keys --keyid-format LONG (get A3CDF698F9B37035 from this)
# gpg --armor --export A3CDF698F9B37035
# add to github

# ssh for github
echo "Go and generate SSH key in Xcode"
# ssh-keyscan github.com >> ~/.ssh/known_hosts