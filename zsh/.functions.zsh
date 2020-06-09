#!/bin/bash

: '
- Description:
    This function sets up new repository with everything you need. 

- Usage: 
    gi <directory-name> 
'
gi() {
    if [[ -n "$1" ]]; then
        mkdir "$1"
        cd "$1" || exit
        git init
        touch README.md
        echo "# $1" > README.md
        touch .gitignore
        echo -e ".DS_Store" > .gitignore
    else
        echo -e "\e[31mDIRECTORY NAME SHOULD BE PASSED\e[0m"
    fi
}

: '
- Description:
    This function creates GitHub repository from existing git repo and sets up origin.
'
rgi() {
    if [[ -d .git ]]; then
        hub create
        git push -u origin HEAD
        open https://github.$(git config remote.origin.url | cut -f2 -d. | tr ':' /)
    else 
        echo -e "\e[31mNOT A GIT REPOSITORY\e[0m"
    fi
}

: '
- Description:
    This function sets up git repository, then make GitHub repo and sets up origin.

- Usage: 
    fgi <directory-name>

- Required:
    https://hub.github.com
'
fgi() {
    if [[ -n "$1" ]]; then
        gi "$1"
        git add .
        git commit -m "init: ✨"
        rgi
    else 
        echo -e "\e[31mDIRECTORY NAME SHOULD BE PASSED\e[0m"
    fi
}

# Returns errlvl 0 if $1 is a reachable git remote url 
is_git_remote_url_reachable() {
    git ls-remote "$1" CHECK_GIT_REMOTE_URL_REACHABILITY >/dev/null 2>&1
}

: '
- Description:
    This function creates directory and git repository from currently opened GitHub repo in Safari (also sets  up remote). 
'
ghi() {
    url=$(osascript -e 'tell application "Safari" to return URL of front document')
    if is_git_remote_url_reachable "$url"; then
        dir_name=${url##*/}
        cd ~/Downloads || exit
        mkdir "$dir_name"
        cd "$dir_name" || exit
        git init
        echo "# $dir_name" >> README.md
        git add README.md
        git commit -m "init: ✨"
        git remote add origin "$url"
        git push -u origin master
    else
        echo -e "\e[31mBAD URL\e[0m"
    fi
}

: '
- Description:
    This function for local quick updates.

- Usage: 
    qu <files-to-git-add>
'
qu() {
    if [[ -d .git ]]; then
        if [ -z "$@" ]; then
            git add .
        else 
            git add "$@"
        fi
        git commit -m "Update ⬆️"
    else
        echo -e "\e[31mNOT A GIT REPOSITORY\e[0m"
    fi
}

: '
- Description:
    This function for remote quick updates.

- Usage: 
    rqu <files-to-git-add>
'
rqu() {
    if [[ -d .git ]]; then
        if [ -z "$@" ]; then
            git add .
        else 
            git add "$@"
        fi
        git commit -m "Update ⬆️"
        git push
    else
        echo -e "\e[31mNOT A GIT REPOSITORY\e[0m"
    fi
}

: '
- Description:
    This function acts like rm command, but in safer maner (moves your files and/or directories into Trash).
    
- Usage: 
    t <list-of-files-and/or-directories> (also works if there are only one file/directory)
'
t() {
    if [[ -n "$1" ]]; then
        mv "$@" ~/.Trash
    else
        echo -e "\e[31m!ERROR!\e[0m At least one file/directory name should be passed"
    fi
}

: '
- Description:
    Move to trash current folder.
'
tc() {
    folderName=$(pwd)
    cd ../
    t "$folderName"
}

: '
- Description:
    This function copies current directory path in clipboard.
'
cpwd() { pwd | pbcopy; }

: '
- Description:    
    This function opens current directory in Alfread search.   
' 
awd() { osascript -e "tell application \"Alfred 4\" to browse \"$(pwd)/\""; }

: '
- Description:
    This function copies currently opened page in Safari URL into clipboard.
'
cpsf() { osascript -e 'tell application "Safari" to return URL of front document' | pbcopy; }

: '
- Description:
    This function creates new file and opens it in Sublime.
- Usage:
    cf <file1.ext> <file2.ext>...
'
cf() {
    if [[ -n "$1" ]]; then
        touch "$@"
        subl "$@"
    else
        echo -e "\e[31m!ERROR!\e[0m File name should not be empty"
    fi
}

: '
- Description:
    This function creates directory and then cd into it.
- Usage:
    md <directory-name>
'
md() {
    if [[ -n "$1" ]]; then
        mkdir "$1"
        cd "$1" || exit
    else
        echo -e "\e[31m!ERROR!\e[0m File name should not be empty"
    fi
}

: '
- Description:
    Create new python virtual environment and activate it

- Usage: 
   venv <optional-venv-directory-name>
'
venv() {
    if [[ -n "$1" ]]; then
        python3 -m venv "$1"
        source "$1"/bin/activate
    else 
        python3 -m venv venv
        source venv/bin/activate
    fi
}
