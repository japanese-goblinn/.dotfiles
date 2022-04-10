#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Copy Link
# @raycast.packageName Firefox
# @raycast.mode silent

set -e

LANG="en_US.UTF-8"

link=$( osascript -e  'tell application "System Events" to tell process "Firefox" to get value of UI element 1 of combo box 1 of toolbar "Navigation" of first group of front window' )

# TODO: fix link if it contains spaces (properly encode them with %20, and other symbols)

echo "$link" | pbcopy
echo "Link Copied"
