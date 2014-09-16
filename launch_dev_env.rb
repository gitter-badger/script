#!/usr/bin/env ruby -w
# launch_development_environment.rb
# Author: Andy Bettisworth
# Description: Launch development environment

require 'wmctrl'

wm = WMCtrl.new

## CLOSE all windows
wm_data = wm.list_windows.map { |w| wm.get_window_data(w[:id]) }
wm_data.reject! { |w| w[:state].include?("_NET_WM_STATE_SKIP_PAGER") }
wm_data.reject! { |w| w[:class].include?("desktop_window.Nautilus") }
wm_data.each { |w| wm.action_window(w[:id], :close) }

## NAVIGATE to top left workspace
wm.change_viewport(0,0)

## CREATE processes
pid1 = spawn('gnome-terminal')
pid2 = spawn('sublime')
pid3 = spawn('google-chrome')

sleep(0.5)

## OPEN terminal
wm_terminal = wm.list_windows.select! { |w| w[:class] == "gnome-terminal.Gnome-terminal" }
wm.action_window(wm_terminal[0], :change_state, "add", "maximized_horz", "maximized_vert")
# terminal_window.relocate("top-left");
# terminal_window.change_window_state('add','maximize')

## OPEN text editor
wm_texteditor = wm.list_windows.select! { |w| w[:class] == "sublime.Sublime" }
wm.action_window(wm_texteditor[0], :change_state, "add", "maximized_vert")
# sublime_window.relocate("top-right")
# sublime_window.change_window_state('add','maximize')

## OPEN browser
wm_browser = wm.list_windows.select! { |w| w[:class] == "Google-chrome-stable.Google-chrome-stable" }
wm.action_window(wm_browser[0], :change_state, "add", "maximized_horz", "maximized_vert")
# chrome_window.relocate("bottom-right")
# chrome_window.change_window_state('add','maximize')