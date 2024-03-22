#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.icon 🧭
# @raycast.title Add Tab To Things Inbox
# @raycast.packageName Safari
# @raycast.mode silent

LANG="en_US.UTF-8"

name=$(osascript -e 'tell application "Safari" to return name of front document')
url=$(osascript -e 'tell application "Safari" to return URL of front document')

open "things:///add?title=$name&notes=$url"
echo "Done"