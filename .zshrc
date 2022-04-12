HOMEBREW_PATH="/opt/homebrew/bin"
RUST_PATH="$HOME/.cargo/bin"
SUBLIME_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export PATH="$PATH:$HOME:$HOMEBREW_PATH:$RUST_PATH:$SUBLIME_PATH/:.local/bin"
export DOTFILES_PATH="$( dirname $( realpath ${(%):-%N} ) )"
SHELL_CONFIG_PATH="$DOTFILES_PATH/shell"

# fig prelock
eval "$(fig init zsh pre)"

source "$SHELL_CONFIG_PATH/exports.sh"
source "$SHELL_CONFIG_PATH/aliases.sh"
source "$SHELL_CONFIG_PATH/functions.sh"
source "$SHELL_CONFIG_PATH/prompt.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$DOTFILES_DEPENDECIES_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$DOTFILES_DEPENDECIES_PATH/zsh-you-should-use/you-should-use.plugin.zsh"

# node version manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] \
	&& printf %s "${HOME}/.nvm" \
	|| printf %s "${XDG_CONFIG_HOME}/nvm")"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(fig init zsh post)"
