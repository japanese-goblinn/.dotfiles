#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.icon 🧭
# @raycast.title Current Tab To Things Inbox
# @raycast.description Add current tab with page title and URL to Things.app inbox
# @raycast.packageName Safari
# @raycast.mode silent

LANG="en_US.UTF-8"

name=$(osascript -e 'tell application "Safari" to return name of front document')
url=$(osascript -e 'tell application "Safari" to return URL of front document')

open "things:///add?title=$name&notes=$url"
echo "Done"