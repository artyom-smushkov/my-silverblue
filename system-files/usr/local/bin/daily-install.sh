#!/bin/bash

DESIRED_FLATPAKS_PROGRAMS=$(
echo "me.proton.Pass
com.protonvpn.www
com.github.PintaProject.Pinta
com.github.rafostar.Clapper
com.mattjakeman.ExtensionManager
io.github.flattool.Ignition
io.github.flattool.Warehouse
io.missioncenter.MissionCenter
org.gnome.Calculator
org.gnome.Calendar
org.gnome.Characters
org.gnome.Connections
org.gnome.Contacts
org.gnome.FileRoller
org.gnome.Firmware
org.gnome.Logs
org.gnome.Loupe
org.gnome.Maps
org.gnome.NautilusPreviewer
org.gnome.Papers
org.gnome.TextEditor
org.gnome.Weather
org.gnome.baobab
org.gnome.clocks
org.gnome.font-viewer
org.gnome.Boxes
page.task.Refine
com.slack.Slack
org.telegram.desktop
com.anydesk.Anydesk
org.darktable.Darktable
fm.reaper.Reaper
org.ardour.Ardour
org.guitarix.Guitarix
com.github.wwmm.easyeffects
org.mozilla.Thunderbird
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

brew bundle install --file /var/home/templarrr/.config/brewfile/Brewfile --cleanup --upgrade --upgrade-formulae
