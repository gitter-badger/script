#!/usr/bin/env ruby -w
# launch_development_environment.rb
# Description: Launch development environment

require_relative 'rbwindow'

## Setup development environment
## Setup 2
window = RBWindow.new
window.close_all_windows
window.change_workspace("top-right")

sleep(1)
## Sublime-Text-3
sublime_window = RBWindow.new
sublime_window.create_application("sublime")
sublime_window.relocate("top-right")
sublime_window.change_window_state('add','maximize')

## Gnome-Terminal
terminal_window = RBWindow.new
terminal_window.create_application("gnome-terminal")
terminal_window.relocate("top-left");
terminal_window.change_window_state('add','maximize')

## Chrome
chrome_window = RBWindow.new
chrome_window.create_application("google-chrome", "localhost:3000 localhost:8000")
chrome_window.relocate("bottom-right")
chrome_window.change_window_state('add','maximize')