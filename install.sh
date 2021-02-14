#!/bin/bash

print_error() { 
	local RED="\033[0;31m"
	local NC="\033[0m"
	echo "${RED}$1${NC}"
    exit 1
}

mv ~/dotfiles-plus-plus/ ~/.dotfiles/ || exit
cd .dotfiles/ || exit
git submodule update --init --recursive || exit
cd .. || exit

# link zshrc
ln -s ~/.dotfiles/zsh/.zshrc.zsh ~/.zshrc || exit

# git
ln -s ~/.dotfiles/config/git/.gitconfig ~/.gitconfig || exit

# crontab
crontab ~/.dotfiles/config/cronetab/cronetab.txt && crontab -l || exit

# brew 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || exit

brew install iterm2 || exit
brew install visual-studio-code || exit
brew install iina || exit
brew install paw || exit
brew install figma || exit
brew install fork || exit

brew install micro || exit
brew install bat || exit
brew install httpie || exit
brew install tldr || exit
brew install hub || exit

brew install cocoapods || exit

brew install --cask transmission || exit

# install jetbrains-mono font
brew tap homebrew/cask-fonts || exit
brew install --cask font-jetbrains-mono || exit

# micro config
ln -s ~/.dotfiles/config/micro ~/.config/ || exit

# vscode
xargs -L1 code --install-extension < ~/.dotfiles/config/vscode/extensions.txt || exit
ln -s ~/.dotfiles/config/vscode/settings.json "$HOME/Library/Application\ Support/Code/User/settings.json" || exit

# raycast
git clone "https://github.com/japanese-goblinn/script-commands.git" || exit

# iterm2
# need manual install of iterm config
ln -s ~/.dotfiles/config/iterm/auto_dark_mode.py ~/Library/ApplicationSupport/iTerm2/Scripts/auto_dark_mode.py || exit

# gpg key
(brew install gpg-suite && echo "Go and generate a new key") || exit
# gpg --list-secret-keys --keyid-format LONG (get A3CDF698F9B37035 from this)
# gpg --armor --export A3CDF698F9B37035
# add to github

# ssh for github
echo "Go and generate SSH key in Xcode"