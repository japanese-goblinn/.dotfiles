#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🔈
# @raycast.title Fix Audio Quality
# @raycast.packageName Utils
# @raycast.mode silent

sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod
echo "Done"

