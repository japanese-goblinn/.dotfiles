#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Add To Reminders
# @raycast.description Add current tab URL to Apple Reminders
# @raycast.packageName Firefox
# @raycast.mode silent

name="$( firefox_get_current_tab_name )"
link="$( firefox_get_current_tab_url )"

osascript << EOF
	tell app "Reminders"
		make new reminder in default list with properties {name:"$name", body:"$link"}
	end tell
EOF
echo "Done"