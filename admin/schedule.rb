#!/usr/bin/ruby -w
# schedule.rb
# Author: Andy Bettisworth
# Description: Schedules automated tasks

require 'optparse'
require 'queue_classic'
require 'timers'
require 'timeout'
require 'clockwork'

include Clockwork

require_relative 'admin'

module Admin
  # automate some tasks
  class Schedule
    TASKS = "#{ENV['HOME']}/.sync/.script/.tasks"

    attr_accessor :queue

    def initialize(queue = 'default')
      self.queue = queue
    end

    def task(params)
      @method = params[:method]
      @args   = params[:args]

      if params[:task]
        @method = 'Kernel.load'
        @args   = "#{TASKS}/#{params[:task]}"
      end

      @delay    = params[:delay]
      @interval = params[:interval]
      fail 'Cannot have @interval and @delay' if @interval && @delay

      @repeat = params[:repeat]
      @repeat ||= 1

      execute
    end

    private

    def execute
      timer = Timers.new

      unless @interval
        @delay ||= 1
        timer.every(@delay) do
          enqueue_task(@method, @args)
          QC::Worker.new(q_name: @queue).work
        end

        @repeat.times { timer.wait }
      else
        timer.every(@interval) do
          enqueue_task(@method, @args)
          QC::Worker.new(q_name: @queue).work
        end

        loop { timer.wait }
      end
    end

    def enqueue_task(method, args)
      QC::Queue.new(@queue).enqueue(method, args)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  options = {}
  option_parser = OptionParser.new do |opts|
    executable_name = File.basename($PROGRAM_NAME, '.rb')
    opts.banner = "Usage: #{executable_name} -m METHOD -a ARGS [OPTIONS]..."

    opts.on('-m', ' --method', 'method') do |method|
      options[:method] = method
    end

    opts.on('-a', '--args', 'arguments') do |args|
      options[:args] = args
    end

    opts.on('-q', '--queue', 'custom queue') do |queue|
      options[:queue] = queue
    end

    opts.on('-d', '--delay', 'time inbetween each job') do |delay|
      options[:delay] = delay
    end

    opts.on('-i', '--interval', 'loop jobs indefinitely') do |interval|
      options[:interval] = interval
    end

    opts.on('-r', '--repeat', 'repeat job X times') do |repeat|
      options[:repeat] = repeat
    end

    opts.on('-t', '--task', 'task name (e.g. test_task.rb)') do |task|
      options[:task] = task
    end
  end
  option_parser.parse!

  if options[:method] && options[:args]
    tactical = Schedule.new
    tactical.task(method:   options[:method],
                  args:     options[:args],
                  queue:    options[:queue],
                  delay:    options[:delay],
                  interval: options[:interval],
                  repeat:   options[:repeat],
                  task:     options[:task])
  else
    puts option_parser.help
  end
end
