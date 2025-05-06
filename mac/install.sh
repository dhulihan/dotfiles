# crank up mouse move speed beyond max
defaults write -g com.apple.mouse.scaling -float 8.0

# stop bluetooth media keys from launching itunes
#   https://discussions.apple.com/thread/2570254
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles true; killall Finder

# hide screenshot preview thumbnail
defaults write com.apple.screencapture show-thumbnail -bool false

# make menu bar items tighter
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6

# increase key repeat
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
