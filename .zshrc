# Please check that `readlink /usr/local/share/zsh/site-functions/prompt_pure_setup` is linking correct `$HOME/.dotfiles/dependencies/pure/pure.zsh`
# if not use next commands 
# `unlink /usr/local/share/zsh/site-functions/prompt_pure_setup`
# `ln -s /full/path/to/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup`

fpath=( "$HOME/.dotfiles/dependencies/pure" $fpath)

autoload -U promptinit; promptinit
prompt pure

source ~/.dotfiles/.zprofile
source ~/.dotfiles/.aliases.zsh

source ~/.dotfiles/dependencies/zsh-autosuggestions/zsh-autosuggestions.zsh

# This should be last command
source ~/.dotfiles/dependencies/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
