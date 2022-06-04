#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Add To Reading List
# @raycast.description Add current tab URL to Safari Reading List
# @raycast.packageName Firefox
# @raycast.mode silent

osascript << EOF
	tell app "Safari" to add reading list item "$( firefox_get_current_tab_url )"
EOF

echo "Done"