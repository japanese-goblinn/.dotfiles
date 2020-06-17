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

alias dw='cd ~/Downloads'
alias dtf='cd ~/.dotfiles'
alias sbs='cd ~/Library/ApplicationSupport/Sublime\ Text\ 3/Packages/User'

alias edit='micro ~/.dotfiles/zsh/.aliases.zsh'
alias nedit='nano ~/.dotfiles/zsh/.aliases.zsh'
alias reload='source ~/.zshrc'

# Git
alias g='git'

alias gb='git branch'

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
