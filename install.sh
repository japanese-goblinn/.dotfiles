#!/bin/zsh

set -ex

pre_scripts_install() {
	xcode-select --install
}

brew_install() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
	
	# applications
	brew install iterm2 
	brew install visual-studio-code 
	brew install iina 
	brew install paw 
	brew install figma 
	brew install fork 
	brew install google-chrome 
	brew install --cask transmission
	
	# cli tools
	brew install micro # prime cli text editor
	brew install bat 
	brew install httpie 
	brew install tldr 
	brew install hub 
	brew install coreutils
	brew install cocoapods 
	
	# fonts
	brew tap homebrew/cask-fonts 
	brew install --cask font-jetbrains-mono
}

dotfiles_install() {
	export DOTFILES_PATH=$(dirname $(realpath $0))
	(cd $DOTFILES_PATH && git submodule update --init --recursive) 
	source "$DOTFILES_PATH/.zshrc"
	ln -s "$DOTFILES_PATH/.zshrc" ~/.
}

configs_install() {
	# git
	ln -s "$DOTFILES_CONFIG_PATH/git/.gitconfig" ~/.gitconfig 
	
	# crontab
	crontab "$DOTFILES_CONFIG_PATH/cronetab/cronetab.txt" && crontab -l 
	
	# micro
	ln -s "$DOTFILES_CONFIG_PATH/micro" ~/.config/
	
	# xcode
	(cd "$DOTFILES_CONFIG_PATH/xcode/xcode-github-theme/" && ./install.sh) 
	
	# vscode
	local VSCODE_PATH="$DOTFILES_CONFIG_PATH/vscode/"
	xargs -L1 code --install-extension < "$VSCODE_PATH/extensions.txt"
	ln -s "$VSCODE_PATH/settings.json" ~/Library/Application\ Support/Code/User/settings.json
	
	# raycast
	gcl "https://github.com/japanese-goblinn/script-commands.git"
	
	# iterm2
	echo "iTerm needs manual install of config"
	ln -s ~/.dotfiles/config/iterm/auto_dark_mode.py ~/Library/Application Support/iTerm2/Scripts/AutoLaunch/auto_dark_mode.py
}

keys_install() {
	# gpg key
	brew install gpg-suite && echo "Go and generate a new GPG key"
	# gpg --list-secret-keys --keyid-format LONG (get A3CDF698F9B37035 from this)
	# gpg --armor --export A3CDF698F9B37035
	# add to github
	
	# ssh for github
	echo "Go and generate SSH key in Xcode"
	# ssh-keyscan github.com >> ~/.ssh/known_hosts
}

pre_scripts_install
brew_install
dotfiles_install
configs_install
keys_install
source ~/.zshrc
