#!/usr/bin/env ruby -w
# launch-accreu-feature-accreu-homepage.rb
# Author: Andy Bettisworth
# Description: Launch project accreu

require_relative 'rbwindow'

DESKTOP = "/home/wurde/Desktop"
APP_DIR = "/home/wurde/.sync/.app"

## Setup development environment
## Setup 2
window = RBWindow.new
window.close_all_windows
window.change_workspace("top-right")

## Clone project to Desktop
unless File.exist?("/home/wurde/Desktop/launch-accreu-feature-accreu-homepage")
  system("git clone /home/wurde/.sync/.app/launch-accreu-feature-accreu-homepage /home/wurde/Desktop/launch-accreu-feature-accreu-homepage;")
end

sleep(1)
## Sublime-Text-3
sublime_window = RBWindow.new
sublime_window.create_application("sublime", "/home/wurde/Desktop/launch-accreu-feature-accreu-homepage")
sublime_window.relocate("top-right")
sublime_window.change_window_state('add','fullscreen')

## Gnome-Terminal
terminal_window = RBWindow.new
terminal_window.create_application("gnome-terminal","--working-directory=/home/wurde/Desktop/launch-accreu-feature-accreu-homepage")
terminal_window.relocate("top-left");
terminal_window.change_window_state('add','fullscreen')

## Firefox
firefox_window = RBWindow.new
firefox_window.create_application("firefox", "127.0.0.1:3000")
firefox_window.relocate("bottom-right")
firefox_window.change_window_state('add','fullscreen')
