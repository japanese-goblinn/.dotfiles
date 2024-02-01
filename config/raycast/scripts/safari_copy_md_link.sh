#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.icon 🧭
# @raycast.title Current Tab URL as Markdown link 
# @raycast.packageName Safari
# @raycast.mode silent

LANG="en_US.UTF-8"

name=$(osascript -e 'tell application "Safari" to return name of front document')
url=$(osascript -e 'tell application "Safari" to return URL of front document')
result="[$name]($url)"

echo $result | pbcopy
echo "$result"