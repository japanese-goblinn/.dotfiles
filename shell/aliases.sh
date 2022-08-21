#!/bin/zsh

# General
alias cd="z"
alias icd="zi"
alias m="mkdir -p"
alias mv="mv -iv"
alias cp="cp -riv"
alias ls="exa"
alias ll="exa -la"
alias rld="source ~/.zshrc"
alias f="fork"
alias mk="make"
alias e="subl"
alias find="fd"
alias grep="rg"
alias b="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo $BAT_DARK_THEME || echo $BAT_LIGHT_THEME)"

# Navigation
alias o="open"
alias oc="open ."
alias ..="cd .."
alias ...="cd ../../"

# git
alias g="git"
alias gcm="git commit -m"
alias gs="git status"
alias ga="git add"
alias gph="git push"
alias gpl="git pull"
alias gfe="git fetch"
alias gcl="git clone"

# Rust
alias cg="cargo"

# Swift
alias spm="swift package"

