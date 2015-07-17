#!/usr/bin/env ruby
# wm.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 185131
# Modified At: 2015 0521 185131
# Description: X Window Manager interface

require_relative 'admin'

module Admin
  module WindowManager
    def require_wmctrl
      `which wmctrl`
      unless $? == 0
        raise StandardError, 'The wmctrl system library is required.'
      end
    end

    def environment
      require_wmctrl
      `wmctrl -m`
    end

    def desktops
      require_wmctrl

      desktops = []
      `wmctrl -d`.split(/\n/).each do |desktop|
        desktops.push(desktop)
      end
      desktops
    end

    def window(query)
      require_wmctrl

      windows = windows(query)
      windows.pop
    end

    def windows(query = nil)
      require_wmctrl

      windows = []
      `wmctrl -lpG`.split(/\n/).each do |window|
        windows.push(window)
      end
      windows.map! { |w| w.split }

      windows.collect! do |window|
        window.reverse!
        attr_hash = parse_window_attr(window)
        attr_hash
      end

      windows = filter_windows(windows, query) if query
      windows
    end

    def parse_window_attr(window)
      attr_hash            = {}
      attr_hash[:id]       = window.pop
      attr_hash[:desktop]  = window.pop
      attr_hash[:pid]      = window.pop
      attr_hash[:x]        = window.pop
      attr_hash[:y]        = window.pop
      attr_hash[:width]    = window.pop
      attr_hash[:height]   = window.pop
      attr_hash[:hostname] = window.pop
      attr_hash[:title]    = window.join(' ')
      attr_hash
    end

    def filter_windows(windows, query)
      case
      when query =~ /\h{8}/
        windows = windows.keep_if { |w| w[:id] =~ /#{query}/ } if query
      when query =~ /\d+/
        windows = windows.keep_if { |w| w[:pid] =~ /#{query}/ } if query
      else
        windows = windows.keep_if { |w| w[:title] =~ /#{query}/ } if query
      end
      windows
    end

    def pretty_print_windows(query = nil)
      windows = windows(query)
      if windows
        windows.each do |win|
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
    end

    def close_window(query = nil)
      require_wmctrl
      windows = windows.keep_if { |w| w[:title] =~ /#{query}/ } if query
      `wmctrl -c #{window.pop[:id]}`
    end

    def switch_desktop(desktop)
      require_wmctrl
      `wmctrl -s #{desktop}`
    end

    def change_viewport(x, y)
      require_wmctrl
      `wmctrl -o #{x},#{y}`
    end

    def show_desktop
      require_wmctrl
      `wmctrl -k on`
    end

    def hide_desktop
      require_wmctrl
      `wmctrl -k off`
    end

    def set_title(title = '')
      require_wmctrl
      `wmctrl -r :ACTIVE: -N "#{title}"`
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin::WindowManager
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: wm [options]'

    opts.on('-l', '--list-windows [REGEXP]', 'List matching windows.') do |regexp|
      options[:list_windows]  = true
      options[:list_windows_regexp] = regexp
    end
  end
  option_parser.parse!

  if options[:list_windows]
    pretty_print_windows(options[:list_windows_regexp])
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
  # > list desktops
end
