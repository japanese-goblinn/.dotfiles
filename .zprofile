# vim errors fix
export LC_ALL=en_US.UTF-8

# Add color for directories 
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
    export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
    colorflag="-G"
    export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi


# Some useful functions

: '
- Description:
    This function sets up new repository with everything you need. 

- Usage: 
    gi <directory-name> 
'
gi() {
    if [[ -n "$1" ]]; then
        mkdir $1
        cd $1
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
        gi $1
        git add .
        git commit -m "Init ✨"
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
        cd ~/Downloads
        mkdir $dir_name
        cd $dir_name
        git init
        echo "# $dir_name" >> README.md
        git add README.md
        git commit -m "Init ✨"
        git remote add origin $url
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
        if [[ -n "$@" ]]; then
            git add $@
        else 
            git add .
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
        if [[ -n "$@" ]]; then
            git add $@
        else 
            git add .
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
        mv $@ ~/.Trash
    else
        echo -e "\e[31m!ERROR!\e[0m At least one file/directory name should be passed"
    fi
}


: '
- Description:
    This function copies current directory path in clipboard.
'
cpwd() { pwd | pbcopy }


: '
- Description:
    This function opens current directory in Alfread search.   
' 
awd() { osascript -e "tell application \"Alfred 4\" to browse \"$(pwd)/\"" }


: '
- Description:
    This function creates new file and opens it in Sublime.
- Usage:
    crnf <file.ext>
'
cf() {
    if [[ -n "$1" ]]; then
        touch $@
        subl $@
    else
        echo -e "\e[31m!ERROR!\e[0m File name should not be empty"
    fi
}


: '
- Description:
    This function creates directory and then cd into it.
- Usage:
    crnf <file.ext>
'
md() {
    if [[ -n "$1" ]]; then
        mkdir $1
        cd $1
    else
        echo -e "\e[31m!ERROR!\e[0m File name should not be empty"
    fi
}


