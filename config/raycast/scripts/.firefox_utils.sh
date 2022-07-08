#!/bin/zsh

LANG="en_US.UTF-8"

# only encode ` ` as %20 for now
function _firefox_url_encode() {
    local raw_url
    raw_url="$1"
    local url_encoded
    url_encoded="${raw_url// /%20}"
    echo "$url_encoded"
}

function firefox_get_current_tab_name() {
    name=$( osascript -e 'tell application "System Events" to tell process "Firefox" to get name of front window' )
    echo "$name"
}

function firefox_get_current_tab_url() {
    # IMPORTANT: requires manual configuration to work https://apple.stackexchange.com/questions/404841/get-url-of-opened-firefox-tabs-from-terminal
    url=$( osascript -e  'tell application "System Events" to tell process "Firefox" to get value of UI element 1 of combo box 1 of toolbar "Navigation" of first group of front window' )
    # IMPORTANT: to use this regex syntax you need #!/bin/zsh not #!/bin/bash
    # if url is http - firefox copies it in format `path/` instead of `http://path/` and here is a fix
    if [[ ! "$url" =~ "(https)+" ]]; then
        url="http://$url"
    fi
    _firefox_url_encode "$url"
}

