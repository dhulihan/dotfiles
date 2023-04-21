# crank up mouse move speed beyond max
defaults write -g com.apple.mouse.scaling -float 8.0

# stop bluetooth media keys from launching itunes
#   https://discussions.apple.com/thread/2570254
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

