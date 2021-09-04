# path's
export DOTFILES_DEPENDECIES_PATH="$DOTFILES_PATH/dependencies"
export DOTFILES_CONFIG_PATH="$DOTFILES_PATH/config"
export LAZYGIT_CONFIG_PATH="$DOTFILES_CONFIG_PATH/lazygit"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#cf2f98"

# vim errors fix
export LC_ALL=en_US.UTF-8

# set default editor to micro
export VISUAL=micro
export MICRO_TRUECOLOR=1

# fzf
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview '([[ -f {} ]] && (bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo OneHalfDark || echo Coldark-Cold) --style=numbers --color=always --line-range=:500  {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
"

# bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
