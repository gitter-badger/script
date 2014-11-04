#!/usr/bin/env ruby -w
# pomodoro.rb
# Author: Andy Bettisworth
# Description: Initialize a pomodoro sequence for current terminal

if __FILE__ == $0
  terminal_pid = Process.ppid
  close_terminal = fork do
    exec "sleep 1200; kill -9 #{terminal_pid}"
  end
  Process.detach(close_terminal)
end
