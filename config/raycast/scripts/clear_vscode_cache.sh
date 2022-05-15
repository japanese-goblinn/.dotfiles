#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.icon 🆚
# @raycast.title Clear Visual Studio Code Cache
# @raycast.packageName Utils
# @raycast.mode silent

rm -rf ~/Library/Application\ Support/Code/Cache/*
rm -rf ~/Library/Application\ Support/Code/CachedData/*

echo "Done"