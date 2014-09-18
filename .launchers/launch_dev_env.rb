#!/usr/bin/ruby
# launch_dev_env.rb
# Author: Andy Bettisworth
# Description: Launch development environment

require 'wmctrl'

wm = WMCtrl.new

## GET geometry of desktop
desktop1 = wm.list_desktops[0]
x_boundary = desktop1[:geometry][0]/2
y_boundary = desktop1[:geometry][1]/2

## CLOSE all windows
wm_data = wm.list_windows.map { |w| wm.get_window_data(w[:id]) }
wm_data.reject! { |w| w[:state].include?("_NET_WM_STATE_SKIP_PAGER") }
wm_data.reject! { |w| w[:class].include?("desktop_window.Nautilus") }
wm_data.each { |w| wm.action_window(w[:id], :close) }

sleep(1.2)

wm.change_viewport(0,0)

spawn('gnome-terminal')
spawn('sublime')
spawn('google-chrome')

sleep(1.2)

## OPEN terminal
wm_terminal = wm.list_windows.select! { |w| w[:class] == "gnome-terminal.Gnome-terminal" }
wm.action_window(wm_terminal[0][:id], :move_resize, 0, 0, 0, -1, -1)
wm.action_window(wm_terminal[0][:id], :change_state, "add", "maximized_horz", "maximized_vert")

## OPEN text editor
wm_texteditor = wm.list_windows.select! { |w| w[:class] == "sublime.Sublime" }
wm.action_window(wm_texteditor[0][:id], :move_resize, 0, x_boundary, 0, -1, -1)
wm.action_window(wm_texteditor[0][:id], :change_state, "add", "maximized_vert")

## OPEN browser
wm_browser = wm.list_windows.select! { |w| w[:class] == "Google-chrome-stable.Google-chrome-stable" }
wm.action_window(wm_browser[0][:id], :move_resize, 0, x_boundary, y_boundary, -1, -1)
wm.action_window(wm_browser[0][:id], :change_state, "add", "maximized_horz", "maximized_vert")
