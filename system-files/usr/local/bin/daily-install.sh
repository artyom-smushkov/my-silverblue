#!/bin/bash

DESIRED_FLATPAKS_PROGRAMS=$(
echo "com.bitwarden.desktop
com.slack.Slack
org.telegram.desktop
com.anydesk.Anydesk
org.darktable.Darktable
org.rncbc.qpwgraph
fm.reaper.Reaper
org.gnome.Boxes
org.mozilla.Thunderbird
org.kde.kid3
io.github.zen_browser.zen
com.brave.Browser
io.mpv.Mpv
com.spotify.Client
org.pulseaudio.pavucontrol
org.mozilla.firefox
org.tigervnc.vncviewer
com.github.tchx84.Flatseal
org.audacityteam.Audacity
md.obsidian.Obsidian"
)

CURRENT_FLATPAK_PROGRAMS=$(flatpak list --app --columns=application)

for app in $DESIRED_FLATPAKS_PROGRAMS; do
    if ! echo "$CURRENT_FLATPAK_PROGRAMS" | grep -q "$app"; then
	echo "Installing $app..."
	flatpak install -y "${app}"
    fi
done

echo $DESIRED_FLATPAKS_PROGRAMS

for app in $CURRENT_FLATPAK_PROGRAMS; do
    if ! echo $DESIRED_FLATPAKS_PROGRAMS | grep -q "$app"; then
	echo "Removing $app..."
	flatpak uninstall -y "${app}"
    fi
done
