#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Add Current Tab To Things
# @raycast.description Add current tab with page title and URL to Things 3
# @raycast.packageName Firefox
# @raycast.mode silent

name="$( firefox_get_current_tab_name )"
link="$( firefox_get_current_tab_url )"

open "things:///add?title=$name&notes=$link"
echo "Done"