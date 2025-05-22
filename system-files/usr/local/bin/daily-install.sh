#!/bin/bash

DESIRED_FLATPAKS_PROGRAMS=$(
echo "me.proton.Pass
com.protonvpn.www
com.slack.Slack
org.telegram.desktop
com.anydesk.Anydesk
org.darktable.Darktable
org.rncbc.qpwgraph
fm.reaper.Reaper
org.ardour.Ardour
org.gnome.Boxes
org.mozilla.Thunderbird
org.gnome.Geary
org.kde.kid3
app.zen_browser.zen
com.vivaldi.Vivaldi
com.brave.Browser
io.mpv.Mpv
com.spotify.Client
org.pulseaudio.pavucontrol
org.mozilla.firefox
org.tigervnc.vncviewer
com.github.tchx84.Flatseal
com.geeks3d.furmark
com.valvesoftware.Steam
org.audacityteam.Audacity"
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

brew update
brew bundle install --cleanup --file /var/home/templarrr/.config/brewfile/Brewfile --no-lock
brew upgrade
