#!/bin/zsh

source "./.firefox_utils.sh"

# @raycast.schemaVersion 1
# @raycast.icon 🦊
# @raycast.title Copy Markdown Link
# @raycast.description Forms a markdown link from current tab in frontmost window
# @raycast.packageName Firefox
# @raycast.mode silent

name="$( firefox_get_current_tab_name )"
link="$( firefox_get_current_tab_url )"

echo "[$name]($link)" | pbcopy
echo "Link Copied"
