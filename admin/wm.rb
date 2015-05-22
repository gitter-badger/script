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
      `wmctrl -lpG`.split(/\n/).each do |window|
        windows.push(window)
      end

      windows.map! {|w| w.split }

      windows.collect! do |window|
        window.reverse!
        attr_hash = {}
        attr_hash[:id] = window.pop
        attr_hash[:desktop] = window.pop
        attr_hash[:pid] = window.pop
        attr_hash[:x] = window.pop
        attr_hash[:y] = window.pop
        attr_hash[:width] = window.pop
        attr_hash[:height] = window.pop
        attr_hash[:hostname] = window.pop
        attr_hash[:title] = window.join(' ')
        attr_hash
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

  list_windows.each do |win|
    puts win.inspect
  end
end
