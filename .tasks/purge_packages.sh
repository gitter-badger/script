#!/bin/bash
# remove_packages.sh
# Author: Andy Bettisworth
# Description: Remove system packages

sudo apt-get purge -y deja-dup cups cups-bsd cupts-client cups-common cups-ppdc;
sudo apt-get purge -y onboard firefox firefox-locale-en system-config-printer-gnome;
sudo apt-get purge -y gcalctool aisleriot mahjongg gnomine steam-launcher;
sudo apt-get purge -y gnome-sudoku apache2 apache2ctl apachectl apache2-utils;
sudo apt-get purge -y mysql_config mysql_table libreoffice-draw libreoffice-writer;
sudo apt-get purge -y libreoffice-calc libreoffice-math gimp gwibber empathy;
sudo apt-get purge -y xul-ext-ubufox vino remmina-common vlc unetbootin dolphin;
sudo apt-get purge -y lastfm lastfm-scrobbler gnome-bluetooth usb-creator-gtk;
sudo apt-get purge -y onboard gnome-orca gnome-schedule virt-manager xterm;
sudo apt-get purge -y acroread kde-runtime ubuntuone-installer;
sudo apt-get purge -y rhythmbox-ubuntuone landscape-client-ui-install;

sudo apt-get autoremove -y;

sudo apt-get clean -y;