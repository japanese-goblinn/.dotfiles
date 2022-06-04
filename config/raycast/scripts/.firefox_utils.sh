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

# [Getting URL and Tab Title from Firefox with AppleScript · Matt's programming blog](https://matthewbilyeu.com/blog/2018-08-24/getting-url-and-tab-title-from-firefox-with-applescript)
# [macos - Get URL of opened Firefox tabs from terminal - Ask Different](https://apple.stackexchange.com/questions/404841/get-url-of-opened-firefox-tabs-from-terminal)
function firefox_get_current_tab_url() {
    url=$( osascript -e  'tell application "System Events" to tell process "Firefox" to get value of UI element 1 of combo box 1 of toolbar "Navigation" of first group of front window' )
    # IMPORTANT: to use this regex syntax you need #!/bin/zsh not #!/bin/bash
    # if url is http - firefox copies it in format `path/` instead of `http://path/` and here is a fix
    if [[ ! "$url" =~ "(https)+" ]]; then
        url="http://$url"
    fi
    _firefox_url_encode "$url"
}

