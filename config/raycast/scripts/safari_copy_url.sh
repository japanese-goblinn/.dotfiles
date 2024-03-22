#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Tab URL
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.icon 🧭

LANG="en_US.UTF-8"

url=$(osascript -e 'tell application "Safari" to return URL of front document')

echo $url | pbcopy
echo "$url"
