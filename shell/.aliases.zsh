# General
alias ls='ls -tU' # ls by creation date (macOS only)
alias c='clear'
alias o='open'
alias of='open .'
alias to='touch'
alias e='micro'
alias .='cd -'
alias ..='cd ..'
alias ...='cd ../../'
alias dev='cd ~/Developer'
alias dw='cd ~/Downloads'
alias dtf='cd ~/.dotfiles'
alias edit='micro ~/.dotfiles/zsh/.aliases.zsh'
alias nedit='nano ~/.dotfiles/zsh/.aliases.zsh'
alias reload='source ~/.zshrc'
alias cdiff='code -d'
alias bat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo zenburn || echo GitHub)"
alias bw='brew install'

# Git
alias g='git'

alias gb='git branch'

alias gc='git commit'
alias gcm='git commit -m'
alias gcmi='git commit -m "init: ✨"'
alias gcmr='git commit -m "doc: update README.md"'

alias gch='git checkout'
alias gre='git reset'

alias gs='git status'
alias ga='git add'
alias gl='git log --pretty=oneline --graph'
alias gph='git push'
alias gpl='git pull'
alias gfe='git fetch'
alias gdf='git diff'
alias gcl='git clone'

# Web
alias chrome='open -a "Google Chrome"'

# GitHub
alias gho='open https://github.$(git config remote.origin.url | cut -f2 -d. | tr ':' /)'

# Use this command on file or with some request 
alias json='pygmentize -l json'

#Python
alias ip='ipython'
alias p='python3' 
alias p2='python'
alias pip='pip3'
alias pip2='pip'
alias deac='deactivate'
alias jp='jupyter notebook'

# iOS
alias pu='pod update --verbose'
alias pi='pod install --verbose'
alias pd='pod deintegrate --verbose'
