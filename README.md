# Dotfiles++

![Setup](./media/setup.png)

> Dark & Light appearance depends on macOS theme

This repository is my current `dotfiles` setup and some macOS essential tools.

* `zsh/`
  * `.aliases` - some useful shortcuts to do common stuff faster
  * `.zprofile` - some shell configurations
  * `.functions` - useful shell functions
  * `.zshrc` - loading of `.aliases`, `.zprofile`, `.functions` and all dependencies
* `dependencies/` - all zsh dependencies (like autocompletions or syntax highlighting)
* `customization/` - everything related to my my currently used terminal app [iTerm](https://www.iterm2.com)
* `alfred/` - [amazing](https://www.alfredapp.com) replacement for `Spotlight` with a lot of customizations to increase your productivity
* `config/` - different configurations for apps I use

## ToC

* [Install](#install)
* Dotfiles
  * [Examples](#examples)
    * `.aliases`
    * `.functions`
* [Raycast](#raycast)
* [Thanks](#thanks)

## Install

⚠️ **Please use `zsh` instead of `bash`**

1. Clone this repo in any directory
2. Run following command `./dotfiles-plus-plus/install.sh` and script will do the rest
3. If no errors occurred everything is ready to use ✅

## About dotfiles

### Examples

Some examples. To learn more, please, look into files itself 😇

#### [`.aliases`](zsh/.aliases.zsh)

```bash
# Open GitHub repo for current direcroty
alias gho='open https://github.$(git config remote.origin.url | cut -f2 -d. | tr ':' /)'
```

#### [`.functions`](zsh/.functions.zsh)

```bash
# Creates directory and git repository from currently opened GitHub repo in Safari
ghi() {
    url=$(osascript -e 'tell application "Safari" to return URL of front document')
    if is_git_remote_url_reachable "$url"; then
        dir_name=${url##*/}
        cd ~/Downloads
        mkdir $dir_name
        cd $dir_name
        git init
        echo "# $dir_name" >> README.md
        git add README.md
        git commit -m "init ✨"
        git remote add origin $url
        git push -u origin master
    else
        echo -e "\e[31mBAD URL\e[0m"
    fi
}

# Move to trash instead of instant delete
t() {
    if [[ -n "$1" ]]; then
        mv $@ ~/.Trash
    else
        echo -e "\e[31m!ERROR!\e[0m At least one file/directory name should be passed"
    fi
}
```

## Raycast

Wonderfull tool to user your mac much more efficiently

![Raycast](./media/raycast.png)

## Thanks

[Special thanks to @nikitavoloboev for inspiration](https://github.com/nikitavoloboev)
