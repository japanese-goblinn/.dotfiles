#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🧭
# @raycast.title Fix Safari Extensions
# @raycast.description Use this when safari extension install returning error
# @raycast.packageName Utils
# @raycast.mode silent

"/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister" -f "/Applications/Safari.app"