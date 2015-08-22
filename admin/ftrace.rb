#!/usr/bin/env ruby
# ftrace.rb
# Author: Andy Bettisworth
# Created At: 2015 0715 104755
# Modified At: 2015 0715 104755
# Description: use trace-cmd to monitor processes

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # dump a function trace on a specific process
  class FTrace
    def trace(pid = 1)
      require_trace_cmd
      `sudo trace-cmd record -e all -P #{pid}`
    end

    def require_trace_cmd
      `which trace-cmd`
      fail StandardError, 'Install trace-cmd.' unless $?.exitstatus == 0
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  begin
    pid = Integer(ARGV[0])
  rescue
    puts 'Usage:'
    puts '  ftrace PID'
    exit 1
  end

  monitor = FTrace.new
  monitor.trace(pid)
end
