# Please check that `readlink /usr/local/share/zsh/site-functions/prompt_pure_setup` is linking `$HOME/.dotfiles/dependencies/pure/pure.zsh`
# if not use next commands: 
# 1. `unlink /usr/local/share/zsh/site-functions/prompt_pure_setup`
# 2. `ln -s $HOME/.dotfiles/dependencies/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup`

fpath=("$HOME/.dotfiles/dependencies/pure" $fpath)

autoload -U promptinit; promptinit
prompt pure

source ~/.dotfiles/zsh/.zprofile.zsh
source ~/.dotfiles/zsh/.aliases.zsh
source ~/.dotfiles/zsh/.functions.zsh

source ~/.dotfiles/dependencies/zsh-autosuggestions/zsh-autosuggestions.zsh

# This should be last command
source ~/.dotfiles/dependencies/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Fig ENV VARIABLES
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
