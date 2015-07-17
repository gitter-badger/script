#!/usr/bin/env ruby
# purge_packages.rb
# Author: Andy Bettisworth
# Description: Remove system packages

require_relative 'admin'

module Admin
  # remove these packages
  class PackageBlacklist
    BLACKLIST = [
      'deja-dup', 'cups', 'cups-bsd', 'cups-client', 'cups-common', 'cups-ppdc',
      'onboard', 'firefox', 'firefox-locale-en', 'system-config-printer-gnome',
      'gnome-sudoku', 'aisleriot', 'mahjong', 'gnomine', 'steam-launcher',
      'apache2', 'apache2ctl', 'apachectl', 'apache2-utils',
      'mysql_config', 'mysql_table', 'gwibber', 'empathy',
      'xul-ext-ubufox' 'vino', 'remmina-common', 'vlc', 'unetbootin dolphin',
      'lastfm', 'lastfm-scrobbler', 'gnome-bluetooth', 'usb-creator-gtk',
      'onboard', 'gnome-orca', 'gnome-schedule', 'virt-manager', 'xterm',
      'acroread', 'kde-runtime', 'ubuntuone-installer',
      'rhythmbox-ubuntuone', 'landscape-client-ui-install'
    ]

    def purge
      purge_list = BLACKLIST.join(' ')
      `sudo apt-get purge -y #{purge_list}`
      `sudo apt-get autoremove -y;`
      `sudo apt-get clean -y;`
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  overseer = PackageBlacklist.new
  overseer.purge
end
