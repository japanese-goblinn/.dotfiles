#!/bin/zsh

source "$DOTFILES_PATH/shell/functions.sh"

function setup_global() {
  _print_info "\nRunning global setup phase..."
  # Disable font smoothing
  defaults -currentHost write -g AppleFontSmoothing -int 0
  
  # Disable automatically adjusting brightness
  sudo defaults write "/Library/Preferences/com.apple.iokit.AmbientLightSensor" "Automatic Display Enabled" -bool false
  
  # Allow to use Tab to change focused control in pop up windows
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
}

# Finder
function setup_finder() {
  _print_info "\nRunning Finder setup phase..."
  
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
}

# Activity Monitor
function setup_activity_monitor() {
  _print_info "\nRunning Activity Monitor setup phase..."
  
  # Show all processes in Activity Monitor
  defaults write com.apple.ActivityMonitor ShowCategory -int 0
  
  # Sort Activity Monitor results by CPU usage
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0
}

# Dock
function setup_dock() {
  _print_info "\nRunning Dock setup phase..."
  
  # Position
  defaults write com.apple.dock orientation -string "bottom"
  
  # Size
  defaults write com.apple.dock tilesize -int 58
  
  # Set magnification effect
  defaults write com.apple.dock magnification -bool yes
  # Set magnification dock size
  defaults write com.apple.dock largesize -float 72
  
  # Disable ability to resize dock
  defaults write com.apple.Dock size-immutable -bool yes
  
  # Wipe all (default) app icons from the Dock
  defaults write com.apple.dock persistent-apps -array
  
  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true
  
  # Make Dock icons of hidden applications translucent
  defaults write com.apple.dock showhidden -bool true
}

# SAFARI
function setup_safari() {
  _print_info "\nRunning Safari setup phase..."
  
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
}

# iTerm2
function setup_iterm2() {
  _print_info "\nRunning iTerm2 setup phase..."
  
  # Don’t display the annoying prompt when quitting iTerm
  defaults write com.googlecode.iterm2 PromptOnQuit -bool false
}

# App Store
function setup_app_store() {
  _print_info "\nRunning App Store setup phase..."
  
  # Enable the automatic update check
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
  
  # Check for software updates daily, not just once per week
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
  
  # Download newly available updates in background
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
  
  # Turn on app auto-update
  defaults write com.apple.commerce AutoUpdate -bool true
}

# Transmission
function setup_transmission() {
  _print_info "\nRunning Transmission setup phase..."
  
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
}

# Xcode
function setup_xcode() {
  _print_info "\nRunning Xcode setup phase..."
  
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
}

_print_info "Configuring macOS defaults.."

setup_global
setup_finder
setup_activity_monitor
setup_dock
setup_safari
setup_iterm2
setup_app_store
setup_transmission
setup_xcode

_print_warning "\nSettings -> Trackpad -> More Gestures -> App Exposé"
_print_warning "Settings -> Keyboard -> Shortcuts -> Mission Control -> Disable 'Move left/right a space'"

_print_warning "\nSome defaults can be applied only after restart" 
_print_warning "Do you want to restart your mac now? (y)"
read need_restart
case "$need_restart" in
  "y")
    _print_info "\nRestarting..."
    sudo shutdown -r now
    ;;
  *)
    _print_warning "\n🔪 Killing some app's..."
    _maybe_killall "Finder" "Activity Monitor" "Dock" "Safari" "iTerm2" "App Store" "Transmission" "Xcode"
    ;;
esac
