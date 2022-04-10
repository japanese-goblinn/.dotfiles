#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.icon 📟
# @raycast.title Open Current iTerm Directory in Finder
# @raycast.packageName Utils
# @raycast.mode silent

tell application "iTerm"
    tell the current session of current window
        write text "open -a Finder ./"
    end tell   
end tell
