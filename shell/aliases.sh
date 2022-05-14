#!/bin/bash

# General
alias mk="mkdir -p"
alias mv="mv -iv"
alias cp="cp -riv"
alias ls="exa"
alias ll="exa -la"
alias c="clear"
alias o="open"
alias diff="code -nd"
alias reload="source ~/.zshrc"
alias f="fork"
alias m="make"
alias e="subl"
alias sz="du -sh ."
alias find="fd"
alias grep="rg"
alias b="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo $BAT_DARK_THEME || echo $BAT_LIGHT_THEME)"

# Navigation
alias .="cd -"
alias ..="cd .."
alias ...="cd ../../"
alias dev="cd ~/Developer"
alias dw="cd ~/Downloads"
alias dtf="cd ~/.dotfiles"

# brew
alias br="brew"
alias bri="brew install"
alias brup="brew update && brew cleanup"

# git
alias gu='git add .; git commit -m "update"; git push'
alias g="git"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit -m"
alias gch="git checkout"
alias gre="git reset"
alias gs="git status"
alias ga="git add"
alias gph="git push"
alias gpl="git pull"
alias gfe="git fetch"
alias gcl="git clone"

# Python
alias ip="ipython"
alias p="python3" 
alias p2="python"
alias pip="pip3"
alias pip2="pip"
alias deac="deactivate"
alias jp="jupyter notebook"

# iOS
alias pu="pod update --verbose"
alias pi="pod install --verbose"
alias pd="pod deintegrate --verbose"
alias srm="xcrun simctl uninstall booted"

# Rust
alias cg="cargo"

# Swift
alias spm="swift package"

