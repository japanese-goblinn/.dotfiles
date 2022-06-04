#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Add To Reminders Today
# @raycast.description Add current tab URL to Apple Reminders and set due date Today
# @raycast.packageName Firefox
# @raycast.mode silent

name="$( firefox_get_current_tab_name )"
# We have to escape `"` in AppleScript like this `\"`
# This will replace ALL `"` with `\"`.
# To learn more see https://github.com/dylanaraps/pure-bash-bible#parameter-expansion=
name=${name//'"'/'\"'} 
link="$( firefox_get_current_tab_url )"

# this is for some reason is pretty slow and takes >=11s to execute
osascript << EOF
	tell app "Reminders"
		set rem to make new reminder in default list with properties {name:"$name", body:"$link"}
		set allday due date of rem to (current date) # without this script executes almost immediately
	end tell
EOF
echo "Done"