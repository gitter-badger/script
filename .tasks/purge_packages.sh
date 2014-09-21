#!/bin/bash
# remove_packages.sh
# Author: Andy Bettisworth
# Description: Remove system packages

PACKAGES=(
  deja-dup cups cups-bsd cupts-client cups-common cups-ppdc
  onboard firefox firefox-locale-en system-config-printer-gnome
  gnome-sudoku aisleriot mahjongg gnomine steam-launcher
  apache2 apache2ctl apachectl apache2-utils
  mysql_config mysql_table gwibber empathy
  xul-ext-ubufox vino remmina-common vlc unetbootin dolphin
  lastfm lastfm-scrobbler gnome-bluetooth usb-creator-gtk
  onboard gnome-orca gnome-schedule virt-manager xterm
  acroread kde-runtime ubuntuone-installer
  rhythmbox-ubuntuone landscape-client-ui-install
)

for p in "${PACKAGES[@]}"; do sudo apt-get purge -y $p; done

sudo apt-get autoremove -y;
sudo apt-get clean -y;
