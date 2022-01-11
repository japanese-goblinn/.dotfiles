#!/bin/bash

set -e

echo "Configuring macOS defaults..."

echo "Disabling automatically adjusting brightness..."
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

# Disable automatically rearrange Spaces based on recent use
defaults write com.apple.dock mru-spaces -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the ~/Downloads
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# FINDER

# Show status bar
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

killall Finder

# ACTIVITY MONITOR

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# DOCK

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

killall Dock

# FONTS
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

killall Safari

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

killall Transmission

# XCODE

# show build time
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

echo "✅ Configured successfully"
