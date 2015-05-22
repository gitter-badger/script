#!/usr/bin/env ruby
# wm.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 185131
# Modified At: 2015 0521 185131
# Description: X Window Manager interface

module Admin
  module Window
    def environment
      `wmctrl -m`
    end

    def list_desktops
      `wmctrl -d`
    end

    def list_windows
      windows = []
      `wmctrl -l`.split(/[[:newline:]]/).each do |window|
        puts window
        # windows.push(window.split(/[[:space:]]+/))
      end
      windows
    end

    def close_window(window)
      `wmctrl -c #{window}`
    end

    def switch_desktop(desktop)
      `wmctrl -s #{desktop}`
    end

    def change_viewport(x, y)
      `wmctrl -o #{x},#{y}`
    end

    def show_desktop
      `wmctrl -k on`
    end

    def hide_desktop
      `wmctrl -k off`
    end
  end
end

if __FILE__ == $0
  include Admin::Window

  list_windows.inspect
end
