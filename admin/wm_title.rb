#!/usr/bin/env ruby -w
# wm_title.rb
# Author: Andy Bettisworth
# Created At: 2014 1111 205534
# Modified At: 2014 1111 205534
# Description: set the current window's title

module Admin
  module Window
    class Title
      def set(title='')
        `wmctrl -r :ACTIVE: -N "#{title}"`
      end
    end
  end
end

if __FILE__ == $0
  if ARGV.count > 0
    wm = Admin::Window::Title.new
    wm.set(ARGV.join(' '))
  else
    STDERR.puts 'USAGE: wmtitle.rb TITLE'
    exit 1
  end
end
