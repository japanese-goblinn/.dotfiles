#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Copy Title
# @raycast.packageName Firefox
# @raycast.mode silent

echo "$( firefox_get_current_tab_name )" | pbcopy
echo "Title Copied"
