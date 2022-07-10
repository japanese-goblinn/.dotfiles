#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon icons/warp.png
# @raycast.title Open Current Finder Directory in Warp
# @raycast.packageName Utils
# @raycast.mode silent

path=$( osascript -e 'tell application "Finder" to get the POSIX path of (target of front window as alias)' )
open -a Warp "$path"