# Application Inventory

This is a curated snapshot of the old laptop's `/Applications` directory. It is
an audit record, not an instruction to reinstall everything.

## Installed By The Core Brewfile

- Docker Desktop
- Hack Nerd Font
- iTerm2
- Rectangle
- Visual Studio Code
- Warp
- WezTerm

Blender is in `Brewfile.optional`.

## Strong New-Laptop Candidates

Review these and add wanted items to a Brewfile rather than downloading them
ad hoc:

- AltTab, Arc, Firefox, Google Chrome
- Obsidian, Raycast
- Dropbox, OneDrive, Box
- Slack, Discord, Microsoft Teams, Telegram, WhatsApp, Zoom
- Zotero, Microsoft Word, Excel, PowerPoint
- VLC, The Unarchiver
- GIMP, Inkscape, FreeCAD, Raspberry Pi Imager, balenaEtcher
- Steam and Epic Games Launcher

## Licensed Or Vendor-Managed Software

Install these from the vendor/account portal only if still needed:

- Adobe Creative Cloud, Acrobat, After Effects, Audition, Illustrator,
  Media Encoder, Photoshop, and Premiere Pro
- Maxon Cinema 4D and Houdini
- Loopback and Duet
- GlobalProtect, NordVPN, and Private Internet Access
- Grammarly, Mendeley Desktop, Panopto, and Spark Desktop
- Epson, HP, LaCie, and other hardware utilities
- Xcode from the Mac App Store or Apple Developer downloads

## Specialist Tools To Review

- Anaconda Navigator
- Anycubic Photon Workshop, CHITUBOX, and Meshmixer
- GigaPan, texstudio, x2goclient, and JDownloader2
- BlueStacks, Barrier, Disk Drill, and balenaEtcher
- Any Video Converter and Wondershare UniConverter

## Likely Legacy Or Nonessential

The old machine contains duplicate versions, old vendor utilities, cleaners,
menu-bar tools, launchers, and games. Do not migrate these automatically. In
particular, review old Adobe/Cinema 4D versions, Skype variants, Microsoft Teams
classic, memory/cleaner apps, old VPN clients, and duplicate WhatsApp installs.

For a complete machine-readable snapshot before wiping the old laptop:

```bash
system_profiler SPApplicationsDataType -json > applications.json
brew list --cask > brew-casks.txt
mas list > mac-app-store-apps.txt
```
