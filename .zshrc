fpath+=( "$HOME/.dotfiles/tools/pure" )

autoload -U promptinit; promptinit
prompt pure

source ~/.dotfiles/.zprofile;
source ~/.dotfiles/.aliases.zsh

source ~/.dotfiles/tools/zsh-autosuggestions/zsh-autosuggestions.zsh

# This should be last command
source ~/.dotfiles/tools/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
