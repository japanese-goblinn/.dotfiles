#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Copy Markdown Link
# @raycast.description Forms a markdown link from current tab in frontmost window
# @raycast.packageName Firefox
# @raycast.mode silent

# [Getting URL and Tab Title from Firefox with AppleScript · Matt's programming blog](https://matthewbilyeu.com/blog/2018-08-24/getting-url-and-tab-title-from-firefox-with-applescript)
# [macos - Get URL of opened Firefox tabs from terminal - Ask Different](https://apple.stackexchange.com/questions/404841/get-url-of-opened-firefox-tabs-from-terminal)

set -e

LANG="en_US.UTF-8"

name=$( osascript -e 'tell application "System Events" to tell process "Firefox" to get name of front window')
link=$( osascript -e  'tell application "System Events" to tell process "Firefox" to get value of UI element 1 of combo box 1 of toolbar "Navigation" of first group of front window' )

# TODO: proper url encoding (e.g. if contains spaces encode them with %20)

echo "[$name]($link)" | pbcopy
echo "Link Copied"
