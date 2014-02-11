#!/usr/bin/env ruby -w
# gem_wmctrl.rb
# Description: Interaction with X Window Manager
# Dependencies: libx11-dev, libglib2.0-dev, libxmu-dev

require 'wmctrl'
wm = WMCtrl.instance

### COMMON USAGE ###

## SET desktop constants
x_boundary = wm.list_desktops[0][:geometry][0]
y_boundary = wm.list_desktops[0][:geometry][1]
## NOTE:
#wm.change_viewport(0,0) 						## TOP LEFT
#wm.change_viewport(x_boundary/2,0)				## TOP RIGHT
#wm.change_viewport(x_boundary/2,y_boundary/2) 	## BOTTOM RIGHT
#wm.change_viewport(0,y_boundary/2)				## BOTTOM LEFT
#wm.action_window(window[0][:id], :move_resize, 0, 0, y_boundary/2, 200, 200) 		     ## TOP LEFT
#wm.action_window(window[0][:id], :move_resize, 0, x_boundary/2, y_boundary/2, 200, 200) ## TOP RIGHT

## READ open windows
#puts wm.list_windows
#puts wm.list_windows.delete_if {|window| window[:class] == nil}

## UPDATE target window focus
#target_window = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#wm.action_window(target_window[0][:id], :activate)

## UPDATE target window size
#target_window = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#wm.action_window(target_window[0][:id], :move_resize, 0, x_boundary, y_boundary, 200, 200)

## UPDATE window property
#target_window = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#wm.action_window(target_window[0][:id], :change_state, 'remove', 'fullscreen')
#wm.action_window(target_window[0][:id], :change_state, 'add', 'fullscreen')
#wm.action_window(target_window[0][:id], :change_state, 'toggle', 'fullscreen')

## DELETE target window
#target_window = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#wm.action_window(target_window[0][:id], :close)

### Launch Development Environment ###
## Close active windows
active_windows = wm.list_windows.delete_if {|window| window[:class] == nil}
active_windows.each do |window|
  wm.action_window(window[:id], :close)
  # wm.action_window(window[:id], :close) unless window[:class] == "gnome-terminal.Gnome-terminal"
end
## Launch terminal
system 'gnome-terminal &'
window_terminal = wm.list_windows.select {|window| window[:class] == "gnome-terminal.Gnome-terminal"}
while window_terminal[0].nil?
  window_terminal = wm.list_windows.select {|window| window[:class] == "gnome-terminal.Gnome-terminal"}
  puts 'waiting...'
end
sleep(1)
## Launch sublime
system 'sublime &'
window_sublime = wm.list_windows.select {|window| window[:class] == "sublime.Sublime"}
while window_sublime[0].nil?
  window_sublime = wm.list_windows.select {|window| window[:class] == "sublime.Sublime"}
  puts 'waiting...'
end
## Launch firefox
system 'firefox &'
window_firefox = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
while window_firefox[0].nil?
  window_firefox = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
  puts 'waiting...'
end
## Move and Resize windows
wm.action_window(window_terminal[0][:id], :move_resize, 0, 0, y_boundary/2, 200, 200)
wm.action_window(window_sublime[0][:id], :move_resize, 0, x_boundary/2, y_boundary/2, 200, 200)
wm.action_window(window_firefox[0][:id], :move_resize, 0, x_boundary/2, 0, 200, 200)
wm.action_window(window_terminal[0][:id], :change_state, 'add', 'fullscreen')
wm.action_window(window_sublime[0][:id], :change_state, 'add', 'fullscreen')
wm.action_window(window_firefox[0][:id], :change_state, 'add', 'fullscreen')
sleep(1)
wm.change_viewport(0,0)
sleep(1)
wm.change_viewport(x_boundary/2,0)
sleep(1)
wm.change_viewport(x_boundary/2,y_boundary/2)
sleep(1)
wm.change_viewport(0,y_boundary/2)
### Launch Development Environment ###

### DISCOVERY ###

## WAIT for visible application window on application launch
#system 'firefox &'
#window_firefox = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#while window_firefox[0].nil?
#  window_firefox = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#  puts 'waiting...'
#end
#wm.action_window(window_firefox[0][:id], :move_resize, 0, x_boundary/2, 0, 200, 200)
#wm.action_window(window_firefox[0][:id], :change_state, 'add', 'fullscreen')

## READ system process information
#system 'firefox &'
#puts 'Inpspect ' + $?.inspect.to_s
#puts 'Class? ' + $?.class.to_s
#puts 'PID ' + $?.pid.to_s
#puts 'Stopped? ' + $?.stopped?.to_s
#puts 'Exited? ' + $?.exited?.to_s
#puts 'ExitStatus? ' + $?.exitstatus.to_s
#puts 'done!'

## NOTE Navigate around all viewports (clockwise)
#wm.change_viewwport(x_offset, y_offset)
# point of origin starts from upper left corner of the screen
# the x_offset is the width
# the y_offset is the height
#wm.change_viewport(0,0)
#`sleep .4`
#wm.change_viewport(x_boundary/2,0)
#`sleep .5`
#wm.change_viewport(x_boundary/2,y_boundary/2)
#`sleep .4`
#wm.change_viewport(0,y_boundary/2)

## READ desktop dimensions
#puts 'x ' + wm.list_desktops[0][:geometry][0].to_s
#puts 'y ' + wm.list_desktops[0][:geometry][1].to_s

## READ all window conditions
#puts wm.list_windows(true)

## READ window states
#target_window = wm.windows(wm_class: /^sublime/)
#puts 'Is ' + target_window[0][:class] + ' fullscreen? ' + target_window[0].fullscreen?.to_s
#puts 'Is ' + target_window[0][:class] + ' sticky? ' + target_window[0].sticky?.to_s

## CHECK WMCtrl class
#target_window = wm.windows(wm_class: /^sublime/)
#puts target_window[0].class
#=> WMCtrl::Window

## UPDATE window state
# Format is ('add'|'remove'|'toggle'),property1[,property2]
#w_firefox = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#wm.action_window(w_firefox[0][:id], :change_state, 'add', 'fullscreen')

## UPDATE current viewport
#wm.change_viewport(0,0)

## DELETE active windows
#active_windows = wm.list_windows.delete_if {|window| window[:class] == nil}
#active_windows.each do |window|
#  wm.action_window(window[:id], :close)
#end

## READ window geometry, states, etc...
#w_firefox = wm.list_windows.select {|window| window[:class] == "Navigator.Firefox"}
#puts wm.get_window_data(w_firefox[0][:id])
# :id		 =>	60817590,
# :title	 =>	"Problem loading page - Mozilla Firefox",
# :class	 =>	"Navigator.Firefox",
# :active  =>	nil,
# :desktop => 0,
# :client_machine => "base",
# :pid	 => 2408,
# :geometry=> [1089, 624, 959, 576],
# :state   => ["_NET_WM_STATE_MAXIMIZED_VERT", "_NET_WM_STATE_MAXIMIZED_HORZ"],
# :exterior_frame => [1089, 624, 959, 576],
# :frame_extents  => [0, 0, 0, 0],
# :strut	 => nil

## READ windows WHERE hash var (e.g. :title, :class)
#puts wm.list_windows.delete_if {|window| window[:class] == nil}
# :id=>25165828, :title=>"Desktop", :class=>"desktop_window.Nautilus", :active=>nil, :desktop=>0, :client_machine=>"base"}
# :id=>52428806, :title=>"wurde@base: ~/Desktop", :class=>"gnome-terminal.Gnome-terminal", :active=>true, :desktop=>0, :client_machine=>"base"}
# :id=>52428917, :title=>"wurde@base: ~", :class=>"gnome-terminal.Gnome-terminal", :active=>nil, :desktop=>0, :client_machine=>"base"}
# :id=>56623107, :title=>"~/Desktop/launch_dev.rb - Sublime Text (UNREGISTERED)", :class=>"sublime.Sublime", :active=>nil, :desktop=>0, :client_machine=>"base"}

## READ all windows
#puts wm.list_windows
# :id=>27262980, :title=>"Desktop", :class=>"desktop_window.Nautilus", :active=>nil, :desktop=>0, :client_machine=>"base"}
# :id=>39845891, :title=>"DNDCollectionWindow", :class=>nil, :active=>nil, :desktop=>0, :client_machine=>nil}
# :id=>39845892, :title=>"launcher", :class=>nil, :active=>nil, :desktop=>0, :client_machine=>nil}
# :id=>39845894, :title=>"panel", :class=>nil, :active=>nil, :desktop=>0, :client_machine=>nil}
# :id=>39845895, :title=>"Dash", :class=>nil, :active=>nil, :desktop=>0, :client_machine=>nil}
# :id=>39845896, :title=>"Hud", :class=>nil, :active=>nil, :desktop=>0, :client_machine=>nil}
# :id=>39845897, :title=>"Switcher", :class=>nil, :active=>nil, :desktop=>0, :client_machine=>nil}
# :id=>56623110, :title=>"wurde@base: ~/Desktop", :class=>"gnome-terminal.Gnome-terminal", :active=>true, :desktop=>0, :client_machine=>"base"}
# :id=>58720259, :title=>"~/Desktop/launch_dev.rb - Sublime Text (UNREGISTERED)", :class=>"sublime.Sublime", :active=>nil, :desktop=>0, :client_machine=>"base"}
# :id=>60817590, :title=>"Problem loading page - Mozilla Firefox", :class=>"Navigator.Firefox", :active=>nil, :desktop=>0, :client_machine=>"base"}

## READ enabled actions
#puts wm.supported
# _NET_WM_FULL_PLACEMENT
# _NET_SUPPORTED
# _NET_SUPPORTING_WM_CHECK
# UTF8_STRING
# _NET_CLIENT_LIST
# _NET_CLIENT_LIST_STACKING
# _NET_ACTIVE_WINDOW
# _NET_DESKTOP_VIEWPORT
# _NET_DESKTOP_GEOMETRY
# _NET_CURRENT_DESKTOP
# _NET_NUMBER_OF_DESKTOPS
# _NET_SHOWING_DESKTOP
# _NET_WORKAREA
# _NET_WM_NAME
# _NET_WM_STRUT
# _NET_WM_STRUT_PARTIAL
# _NET_WM_USER_TIME
# _NET_FRAME_EXTENTS
# _NET_FRAME_WINDOW
# _NET_WM_STATE
# _NET_WM_STATE_MODAL
# _NET_WM_STATE_STICKY
# _NET_WM_STATE_MAXIMIZED_VERT
# _NET_WM_STATE_MAXIMIZED_HORZ
# _NET_WM_STATE_SHADED
# _NET_WM_STATE_SKIP_TASKBAR
# _NET_WM_STATE_SKIP_PAGER
# _NET_WM_STATE_HIDDEN
# _NET_WM_STATE_FULLSCREEN
# _NET_WM_STATE_ABOVE
# _NET_WM_STATE_BELOW
# _NET_WM_STATE_DEMANDS_ATTENTION
# _NET_WM_STATE_FOCUSED
# _NET_WM_WINDOW_OPACITY
# _NET_WM_WINDOW_BRIGHTNESS
# _NET_WM_ALLOWED_ACTIONS
# _NET_WM_ACTION_MOVE
# _NET_WM_ACTION_RESIZE
# _NET_WM_ACTION_STICK
# _NET_WM_ACTION_MINIMIZE
# _NET_WM_ACTION_MAXIMIZE_HORZ
# _NET_WM_ACTION_MAXIMIZE_VERT
# _NET_WM_ACTION_FULLSCREEN
# _NET_WM_ACTION_CLOSE
# _NET_WM_ACTION_SHADE
# _NET_WM_ACTION_CHANGE_DESKTOP
# _NET_WM_ACTION_ABOVE
# _NET_WM_ACTION_BELOW
# _NET_WM_WINDOW_TYPE
# _NET_WM_WINDOW_TYPE_DESKTOP
# _NET_WM_WINDOW_TYPE_DOCK
# _NET_WM_WINDOW_TYPE_TOOLBAR
# _NET_WM_WINDOW_TYPE_MENU
# _NET_WM_WINDOW_TYPE_SPLASH
# _NET_WM_WINDOW_TYPE_DIALOG
# _NET_WM_WINDOW_TYPE_UTILITY
# _NET_WM_WINDOW_TYPE_NORMAL
# WM_DELETE_WINDOW
# _NET_WM_PING
# _NET_WM_MOVERESIZE
# _NET_MOVERESIZE_WINDOW
# _NET_RESTACK_WINDOW
# _NET_WM_FULLSCREEN_MONITORS

## READ available desktops
#puts wm.list_desktops
# :id 		=>	0
# :current	=>	true
# :geometry	=>	[2048, 1200]
# :viewport	=>	[0, 0]
# :workarea	=>	[65, 24, 959, 576]

## READ window manager information
#puts wm.info
# :name			   =>  "Compiz"
# :pid			   =>  nil
# :showing_desktop =>  "OFF"
