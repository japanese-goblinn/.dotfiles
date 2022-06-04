#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Add To Reminders
# @raycast.description Add current tab URL to Apple Reminders
# @raycast.packageName Firefox
# @raycast.mode silent

name="$( firefox_get_current_tab_name )"
# We have to escape `"` in AppleScript like this `\"`
# This will replace ALL `"` with `\"`.
# To learn more see https://github.com/dylanaraps/pure-bash-bible#parameter-expansion=
name=${name//'"'/'\"'} 
link="$( firefox_get_current_tab_url )"

osascript << EOF
	tell app "Reminders"
		make new reminder in default list with properties {name:"$name", body:"$link"}
	end tell
EOF
echo "Done"