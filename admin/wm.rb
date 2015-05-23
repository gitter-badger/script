#!/usr/bin/env ruby
# wm.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 185131
# Modified At: 2015 0521 185131
# Description: X Window Manager interface

require 'optparse'

module Admin
  module WindowManager
    def environment
      `wmctrl -m`
    end

    def desktops
      `wmctrl -d`
    end

    def windows
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

    def pretty_print_windows
      list = windows
      list.each do |win|
        puts <<-WIN
id:       #{win[:id]}
desktop:  #{win[:desktop]}
process:  #{win[:pid]}
origin:   #{win[:x]}, #{win[:x]}
geometry: #{win[:width]}, #{win[:height]}
hostname: #{win[:hostname]}
title:    #{win[:title]}

        WIN
      end
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

    def set_title(title='')
      `wmctrl -r :ACTIVE: -N "#{title}"`
    end
  end
end

if __FILE__ == $0
  include Admin::WindowManager

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: wm [options]"

    opts.on('--list-desktops', 'List all desktops.') do
      options[:list_desktops] = true
    end

    opts.on('-l', '--list-windows', 'List all windows.') do
      options[:list_windows] = true
    end
  end
  option_parser.parse!

  if options[:list_desktops]
    puts desktops
  elsif options[:list_windows]
    pretty_print_windows
  else
    puts option_parser
  end

  # > show active desktop
  # > show active window
  # > switch active desktop
  # > switch active window
  # > close window
  # > toggle show desktop mode
  # > change viewport
  # > set window title
  # > maximize window
  # > minimize window
  # > set window geometry
  # > get window info
end
