#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.icon 🧭
# @raycast.title Copy Tab URL as Markdown Link 
# @raycast.packageName Safari
# @raycast.mode silent

LANG="en_US.UTF-8"

# TODO: fix safari with tab group now inserts `TabGroupName —` at the begining of the name

name=$(osascript -e 'tell application "Safari" to return name of front document')
url=$(osascript -e 'tell application "Safari" to return URL of front document')
result="[$name]($url)"

echo $result | pbcopy
echo "$result"