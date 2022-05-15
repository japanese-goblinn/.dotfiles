#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🔐
# @raycast.title Generate Password
# @raycast.argument1 { "type": "text", "placeholder": "Length", "optional": true }
# @raycast.packageName Utils
# @raycast.mode silent

length="$1"
if [[ -z "$length" ]]; then
	length=30
fi
openssl rand -base64 "$length" | head -c "$length"| pbcopy
echo "Password Generated"