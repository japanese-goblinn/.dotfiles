export DOTFILES_PATH=$(dirname $(realpath ${(%):-%N}))

SHELL_CONFIGS_PATH="$DOTFILES_PATH/shell"

source "$SHELL_CONFIGS_PATH/.shell_exports.zsh"

source "$SHELL_CONFIGS_PATH/.aliases.zsh"
source "$SHELL_CONFIGS_PATH/.functions.zsh"
source "$SHELL_CONFIGS_PATH/.prompt.zsh"

source "$DOTFILES_DEPENDECIES_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" # This should be last command
