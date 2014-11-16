#!/usr/bin/env ruby -w
# wmtitle.rb
# Author: Andy Bettisworth
# Created At: 2014 1111 205534
# Modified At: 2014 1111 205534
# Description: set the current window's title

class SetWMTitle
  def set(*args)
    if args.count > 0
      `wmctrl -r :ACTIVE: -N "#{args.join(' ')}"`
    end
  end
end

if __FILE__ == $0
  if ARGV.count > 0
    wm = SetWMTitle.new
    wm.set(ARGV)
  else
    STDERR.puts 'USAGE: wmtitle.rb TITLE'
    exit 1
  end
end
