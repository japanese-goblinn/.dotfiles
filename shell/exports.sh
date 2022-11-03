HOMEBREW_PATH="/opt/homebrew/bin"
RUST_PATH="$HOME/.cargo/bin"
SUBLIME_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export PATH="$PATH:$HOME:$HOMEBREW_PATH:$RUST_PATH:$SUBLIME_PATH"
typeset -U PATH # Remove duplicates in $PATH

# path's
export DOTFILES_DEPENDECIES_PATH="$DOTFILES_PATH/dependencies"
export DOTFILES_CONFIG_PATH="$DOTFILES_PATH/config"

# goku
export GOKU_EDN_CONFIG_FILE="$DOTFILES_CONFIG_PATH/karabiner/dsl.edn"

# bat
export BAT_LIGHT_THEME="gruvbox-light"
export BAT_DARK_THEME="gruvbox-dark"

# fzf
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview '([[ -f {} ]] && (bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo $BAT_DARK_THEME || echo $BAT_LIGHT_THEME) --style=numbers --color=always --line-range=:500  {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
"

# disables statistics that brew collects
export HOMEBREW_NO_ANALYTICS=1  

# colorized man page
export MANPAGER="sh -c 'col -bx | bat --paging=never --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo $BAT_DARK_THEME || echo $BAT_LIGHT_THEME) -l man -p'"

# vim errors fix
export LC_ALL="en_US.UTF-8"

# set default editor
export VISUAL="subl"
