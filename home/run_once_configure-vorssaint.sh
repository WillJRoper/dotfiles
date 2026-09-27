#!/bin/bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
    exit 0
fi
if pgrep -x Vorssaint >/dev/null 2>&1; then
    echo "Quit Vorssaint before applying its preferences" >&2
    exit 1
fi

domain="com.vorssaint.utils"

defaults write "$domain" autoQuitEnabled -bool true
defaults write "$domain" batteryLimitPercent -int 10
defaults write "$domain" clipboardAutoClearDelaySeconds -int 20
defaults write "$domain" clipboardHistoryEnabled -bool true
defaults write "$domain" clipboardHistoryLimit -int 250
defaults write "$domain" clipboardHistoryShortcut -string "control+command:9"
defaults write "$domain" colorPickerFormat -string "hex"
defaults write "$domain" defaultDurationMinutes -int 0
defaults write "$domain" dockClickCycleWindows -bool true
defaults write "$domain" dockPreviewBackgroundOpacity -float 0.5
defaults write "$domain" dockPreviewEnabled -bool true
defaults write "$domain" keepAwakeConnectedToPower -bool true
defaults write "$domain" keepAwakeExternalDisplay -bool false
defaults write "$domain" keepAwakeIconTint -string "orange"
defaults write "$domain" keepAwakeMouseJiggleIntervalMinutes -int 5
defaults write "$domain" launchAtLoginWanted -bool true
defaults write "$domain" menuBarMetricAppearance -string "values"
defaults write "$domain" micMuteShortcut -string "control+command:46"
defaults write "$domain" monitorAlertBatteryPercent -int 15
defaults write "$domain" monitorAlertCooldownMinutes -int 15
defaults write "$domain" monitorAlertCPUTemperatureThreshold -int 90
defaults write "$domain" monitorAlertCPUThreshold -int 90
defaults write "$domain" monitorAlertDiskFreePercent -int 10
defaults write "$domain" monitorIntervalSeconds -int 2
defaults write "$domain" monitorMemoryMetric -string "used"
defaults write "$domain" monitorPwrTemperature -bool true
defaults write "$domain" previewSize -string "normal"
defaults write "$domain" quickLauncherShortcut -string "control+command:12"
defaults write "$domain" shelfEnabled -bool true
defaults write "$domain" shelfShortcut -string "control+command:2"
defaults write "$domain" soundOutputSwitcherShortcut -string "control+command:31"
defaults write "$domain" switcherMinimizedPlacement -string "hidden"
defaults write "$domain" switcherSearchPinEnabled -bool true
defaults write "$domain" switcherTakeOverSystemShortcuts -bool true
defaults write "$domain" urlCleanerEnabled -bool true
defaults write "$domain" whatsAppDownloadsRetentionDays -int 7
defaults write "$domain" whatsAppOrganizerDelayMinutes -int 5
