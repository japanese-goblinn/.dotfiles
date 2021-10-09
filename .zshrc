# TODO: move to another config file
HOMEBREW_PATH="/opt/homebrew/bin"
RUST_PATH="$HOME/.cargo/bin"
export PATH="$HOMEBREW_PATH:$RUST_PATH:$PATH"

export DOTFILES_PATH=$( dirname $( realpath ${(%):-%N} ) )

SHELL_CONFIGS_PATH="$DOTFILES_PATH/shell"

source "$SHELL_CONFIGS_PATH/exports.sh"
source "$SHELL_CONFIGS_PATH/aliases.sh"
source "$SHELL_CONFIGS_PATH/functions.sh"
source "$SHELL_CONFIGS_PATH/prompt.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$DOTFILES_DEPENDECIES_PATH/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
