#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🎧
# @raycast.title Reload CoreAudio
# @raycast.packageName Utils
# @raycast.mode silent

sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod
echo "Done"

