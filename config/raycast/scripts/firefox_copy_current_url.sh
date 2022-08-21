#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Copy URL
# @raycast.packageName Firefox
# @raycast.mode silent

echo "$( firefox_get_current_tab_url )" | pbcopy
echo "URL Copied"
