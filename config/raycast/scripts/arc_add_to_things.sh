#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.icon icons/arc.png
# @raycast.title Add Current Tab To Things Inbox
# @raycast.description Add current tab with page title and URL to Things.app inbox
# @raycast.packageName Arc
# @raycast.mode silent

LANG="en_US.UTF-8"

name="$( osascript -e 'tell application "Arc" to get title of active tab of front window')"
url="$( osascript -e 'tell application "Arc" to get URL of active tab of front window' )"

open "things:///add?title=$name&notes=$url"
echo "Done"