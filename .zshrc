export PATH="/opt/homebrew/bin:$PATH"

export DOTFILES_PATH=$( dirname $( realpath ${(%):-%N} ) )

SHELL_CONFIGS_PATH="$DOTFILES_PATH/shell"

source "$SHELL_CONFIGS_PATH/.shell_exports.sh"

source "$SHELL_CONFIGS_PATH/.aliases.sh"
source "$SHELL_CONFIGS_PATH/.functions.sh"
source "$SHELL_CONFIGS_PATH/.prompt.sh"

source "$DOTFILES_DEPENDECIES_PATH/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # This should be last command
