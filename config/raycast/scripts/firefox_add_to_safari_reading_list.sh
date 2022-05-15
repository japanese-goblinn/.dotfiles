#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Add To Reading List
# @raycast.description Add current tab URL to Safari Reading List
# @raycast.packageName Firefox
# @raycast.mode silent

# [Getting URL and Tab Title from Firefox with AppleScript · Matt's programming blog](https://matthewbilyeu.com/blog/2018-08-24/getting-url-and-tab-title-from-firefox-with-applescript)
# [macos - Get URL of opened Firefox tabs from terminal - Ask Different](https://apple.stackexchange.com/questions/404841/get-url-of-opened-firefox-tabs-from-terminal)

LANG="en_US.UTF-8"

link=$( osascript -e  'tell application "System Events" to tell process "Firefox" to get value of UI element 1 of combo box 1 of toolbar "Navigation" of first group of front window' )

osascript << EOF
	tell app "Safari" to add reading list item "$link"
EOF

echo "Done"