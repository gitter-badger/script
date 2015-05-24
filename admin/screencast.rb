#!/usr/bin/env ruby
# screencast.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 182728
# Modified At: 2015 0521 182728
# Description: Record a window as a PNG and JSON metadata

require 'optparse'
require 'fileutils'

require_relative 'wm'

module Admin
  module WindowManager
    class Screencast
      attr_accessor :query
      attr_accessor :name
      attr_accessor :timeout
      attr_accessor :delay

      def require_recordmydesktop
        `which recordmydesktop`
        unless $? == 0
          raise StandardError, 'The recordmydesktop application is required.'
        end
      end

      def start!
        require_recordmydesktop

        puts "Starting Capture"
        puts "================"

        setup_project
        cmd = build_command
        puts cmd
        # `#{cmd}`
      end

      private

      def setup_project
        name   = @name if @name
        name ||= 'screencast'
        dir    = "#{ENV['HOME']}/Desktop/#{name}"

        FileUtils.rm_r(dir)
        FileUtils.mkdir_p(dir)
        Dir.chdir(dir)
      end

      def build_command
        cmd  = ""
        cmd += " timeout #{@timeout}" if @timeout
        cmd += " recordmydesktop"
        cmd += " --overwrite"
        cmd += " --v_quality 35"
        cmd += " -o #{@name}" if @name
        cmd
      end
    end
  end
end

if __FILE__ == $0
  include Admin::WindowManager

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: screencast [options]"

    opts.on('-w', '--window QUERY', 'Record a specific window.') do |query|
      options[:query] = query
    end

    opts.on('-n', '--name NAME', 'Give output files a name.') do |name|
      options[:name] = name
    end

    opts.on('-t', '--timeout MINUTES', 'Timeout after N minutes.') do |minutes|
      options[:timeout] = minutes
    end
  end
  option_parser.parse!

  ep = Screencast.new
  ep.query   = options[:query]   if options[:query]
  ep.name    = options[:name]    if options[:name]
  ep.timeout = options[:timeout] if options[:timeout]
  ep.start!
end
