#!/bin/bash

# General
alias mk="mkdir -p"
alias mv="mv -iv"
alias cp="cp -riv"
alias ls="exa"
alias ll="exa -la"
alias c="clear"
alias o="open"
alias oc="open ."
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
alias ..="cd .."
alias ...="cd ../../"
alias dev="cd ~/Developer"
alias dw="cd ~/Downloads"
alias dtf="cd ~/.dotfiles"
alias kb="cd /Users/japanese_goblinn/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Knowledge\ Base"

# brew
alias br="brew"
alias bri="brew install"
alias brup="brew update && brew cleanup"

# git
alias g="git"
alias gb="git branch"
alias gcm="git commit -m"
alias gch="git checkout"
alias gs="git status"
alias ga="git add"
alias gac="git add ."
alias gph="git push"
alias gpl="git pull"
alias gfe="git fetch"
alias gcl="git clone"

# Python
alias p="python3" 
alias p2="python"

# Rust
alias cg="cargo"

# Swift
alias spm="swift package"

