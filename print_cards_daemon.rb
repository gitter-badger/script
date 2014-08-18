#!/usr/bin/ruby -w
# print_cards_daemon.rb
# Author: Andy Bettisworth
# Description: Print all PDF found as an Daemon

require 'rubygems'
require 'daemons'

Daemons.run('watcher.rb')

## COMMANDS
# ruby print_cards_daemon.rb start
# ruby print_cards_daemon.rb restart
# ruby print_cards_daemon.rb stop

## NOTES
# Daemon writes the process id into a file called print_cards.rb.pid
# You can pass arguments after a double-hyphen
# `ruby print_cards_daemon.rb start -- /tmp/cards 5`
