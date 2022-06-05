# path's
export DOTFILES_DEPENDECIES_PATH="$DOTFILES_PATH/dependencies"
export DOTFILES_CONFIG_PATH="$DOTFILES_PATH/config"

# zsh-you-should-use
export YSU_MESSAGE_POSITION="after"

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
