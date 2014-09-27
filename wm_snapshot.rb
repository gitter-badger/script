#!/usr/bin/env ruby -w
# wm_snapshot.rb
# Author: Andy Bettisworth
# Description: use wmctrl to take a snapshot of the current window arrangement

require 'wmctrl'

wm = WMCtrl.new
wm_data = wm.list_windows.map { |w| wm.get_window_data(w[:id]) }
wm_data.reject! { |w| w[:state].include?("_NET_WM_STATE_SKIP_PAGER") }
puts wm_data

# > GET cmd to put into spawn() for each unique window :class (show :title)

# > EXEC processes; sleep(.5) after each
# sleep(0.5)
# > SET desktop
# > SET geometry if any
# > SET state if any
# > SET active

