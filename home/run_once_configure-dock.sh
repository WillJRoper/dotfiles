#!/bin/bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
    exit 0
fi
if ! command -v dockutil >/dev/null 2>&1; then
    echo "dockutil not found; install the core Brewfile first" >&2
    exit 1
fi

add_app() {
    if [ -d "$1" ]; then
        dockutil --add "$1" --section apps --no-restart
    else
        echo "Skipping missing Dock app: $1"
    fi
}

add_small_spacer() {
    dockutil --add "" --type small-spacer --section apps --no-restart
}

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock largesize -float 89
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mineffect -string genie
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -float 40

dockutil --remove all --no-restart

add_small_spacer
add_app "/System/Applications/Siri.app"
add_small_spacer
add_app "/System/Applications/Apps.app"
add_app "/Applications/Arc.app"
add_app "/Applications/Slack.app"
add_app "/System/Applications/Mail.app"
add_app "/Applications/WezTerm.app"
add_app "/System/Applications/Calendar.app"
add_small_spacer
add_app "/System/Applications/Notes.app"
add_app "/System/Applications/App Store.app"
add_app "/System/Applications/System Settings.app"
add_app "/System/Applications/Preview.app"
add_app "/System/Library/CoreServices/Applications/Feedback Assistant.app"

if [ -d "$HOME/Downloads" ]; then
    dockutil --add "$HOME/Downloads" --section others --view auto \
        --display stack --sort dateadded --no-restart
fi

killall Dock 2>/dev/null || true
