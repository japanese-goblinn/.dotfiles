#!/bin/bash

set -x

echo "Configuring macOS defaults..."

echo "Disabling automatically adjusting brightness..."
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

# This one allows to use Tab to change focused control in pop up windows
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable automatically rearrange Spaces based on recent use
defaults write com.apple.dock mru-spaces -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the clipboard
defaults write com.apple.screencapture target -string "clipboard"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Allow text selection in the Quick Look window
defaults write com.apple.finder QLEnableTextSelection -bool true

# FINDER

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Show status bar (at bottom number of items and size)
defaults write com.apple.finder ShowStatusBar -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use gallery view in all Finder windows by default
# View modes: `Nlsv`, `icnv`, `Clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Clmv"

# Keep folders on top when sorting by name:
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show file extensions in Finder:
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Avoid creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show Path Bar at bottom
defaults write com.apple.finder ShowPathbar -bool true

# ACTIVITY MONITOR

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# DOCK

# Disable ability to resize dock
defaults write com.apple.Dock size-immutable -bool yes

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# FONTS

# disable font smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0

# SAFARI

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# ITERM

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# APP STORE

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# TRANSMISSION

# Use `~/Documents/Torrents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"

# Use `~/Downloads` to store completed downloads
defaults write org.m0k.transmission DownloadLocationConstant -bool true

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# XCODE

# Show build time
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# Skip the code folding animation in refactoring
defaults write com.apple.dt.Xcode CodeFoldingAnimationSpeed -int 0

# This will show you why a particular file is having trouble being compiled for indexing.
defaults write com.apple.dt.Xcode IDEIndexShowLog -bool YES

# Show Indexing numeric progress
defaults write com.apple.dt.Xcode IDEIndexerActivityShowNumericProgress -bool YES

# Reduce the number of compile tasks and stop indexing
defaults write com.apple.dt.XCode IDEIndexDisable 1 

echo "✅ Configured successfully"

echo "ℹ️ Settings -> Trackpad -> More Gestures -> App Exposé"
echo "ℹ️ Settings -> Keyboard -> Shortcuts -> Mission Control -> Disable 'Move left/right a space'"

killall Dock
killall Finder
killall Safari
killall Transmission
