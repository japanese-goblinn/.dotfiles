# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"

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
    This function sets remote for git repository in current directory with currently opened Safari tab.
'
ghri() {
    if [[ -d .git ]]; then
        url=$(osascript -e 'tell application "Safari" to return URL of front document')
        if git-remote-url-reachable "$url"; then
            git add .
            git commit -m "Init"
            git remote add origin $url
            git push -u origin master
        else
            echo -e "\e[31mBAD URL\e[0m"
        fi
    else 
        echo -e "\e[31mNOT A GIT REPOSITORY\e[0m"
    fi
}

## Returns errlvl 0 if $1 is a reachable git remote url 
git-remote-url-reachable() {
    git ls-remote "$1" CHECK_GIT_REMOTE_URL_REACHABILITY >/dev/null 2>&1
}


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
        echo "# $1 project" > README.md
        touch .gitignore
        echo -e ".DS_Store" > .gitignore
    else
        echo -e "\e[31m!ERROR!\e[0m Directory name should be passed"
    fi
}


# TODO
: '
- Description:
    This function creates directoy and git repository in it from currently created repo on GitHub. 
'
ghi() {}


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
crnf() {
    if [[ -n "$1" ]]; then
        touch $1
        subl $1
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


: '
- Description:
    This function for local quick updates.
'
ru() {
    if [[ -d .git ]]; then
        git add .
        git commit -m "Update"
    else
        echo -e "\e[31mNOT A GIT REPOSITORY\e[0m"
    fi
}


: '
- Description:
    This function for remote quick updates.
'
rur() {
    if [[ -d .git ]]; then
        git add .
        git commit -m "Update"
        git push
    else
        echo -e "\e[31mNOT A GIT REPOSITORY\e[0m"
    fi
}


