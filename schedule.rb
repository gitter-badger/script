#!/usr/bin/ruby -w
# schedule.rb
# Author: Andy Bettisworth
# Description: My replacement for cron tasks

require 'optparse'
require 'queue_classic'
require 'timers'
require 'timeout'
require 'clockwork'

include Clockwork

class Schedule
  attr_accessor :queue, :method, :args, :script, :delay, :interval, :repeat

  def task(params)
    @queue   = params[:queue]
    @queue ||= 'default'
    @method  = params[:method]
    @args    = params[:args]
    if params[:script]
      @method = 'Kernel.load'
      @args   = ENV['HOME'] + '/.sync/.script/routine/' + params[:script]
    end
    @delay    = params[:delay]
    @interval = params[:interval]
    fail "Cannot have --interval #{@interval} and --delay #{@delay}" if @delay && @interval
    @repeat = params[:repeat]
    @repeat ||= 1
    execute
  end

  private

  def execute
    timer = Timers.new
    unless @interval
      @delay ||= 1;
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

####################
### OptionParser ###
# options = {}
# option_parser = OptionParser.new do |opts|
#   executable_name = File.basename($PROGRAM_NAME, ".rb")
#   opts.banner = "Usage: #{executable_name} -m METHOD -a ARGS [OPTIONS]..."

#   opts.on('-m METHOD','--method METHOD', 'task to execute') do |method|
#     options[:method] = method
#   end

#   opts.on('-a ARGS','--args ARGS', 'task arguments') do |args|
#     options[:args] = args
#   end

#   opts.on('-q QUEUE','--queue QUEUE', 'custom queue') do |queue|
#     options[:queue] = queue
#   end

#   opts.on('-d DELAY','--delay DELAY', 'time inbetween each job') do |delay|
#     options[:delay] = delay.to_i
#   end

#   opts.on('-i INTERVAL','--interval INTERVAL', 'loop jobs indefinitely') do |interval|
#     options[:interval] = interval.to_i
#   end

#   opts.on('-r REPEAT','--repeat REPEAT', 'repeat job X times') do |repeat|
#     options[:repeat] = repeat.to_i
#   end

#   opts.on('-s SCRIPT','--script SCRIPT', 'script path') do |script|
#     options[:script] = script
#   end
# end
# option_parser.parse!

#@tactical.= Schedule.new
# if options[:script]
#  @tactical.task(queue:    options[:queue],
#                 delay: options[:delay],
#                 interval: options[:interval],
#                 repeat: options[:repeat],
#                 script: options[:script])

# elsif options[:method]  && options[:args]
#  @tactical.task(method:   options[:method],
#                 args:     options[:args],
#                 queue:    options[:queue],
#                 delay: options[:delay],
#                 interval: options[:interval],
#                 repeat: options[:repeat])
# else
#   puts option_parser.help
# end
### OptionParser ###
####################

######################
### TESTS: feature ###

describe Schedule do
  describe "#task" do
    before(:each) do
      @tactical = Schedule.new
    end

    def expect_default
      expect(@tactical.method).to eq("puts")
      expect(@tactical.args).to eq("Testing 1 2 3")
      expect(@tactical.queue).to eq("default")
    end

    it "should accept method: 'puts' and args: 'Testing 1 2 3'" do
      @tactical.task(method: 'puts', args: 'Testing 1 2 3')
      expect_default
    end

    it "should accept custom queue: 'routine'" do
      @tactical = Schedule.new()
      @tactical.task(queue: 'routine', method: 'puts', args: 'Testing 1 2 3')
      expect(@tactical.method).to eq("puts")
      expect(@tactical.args).to eq("Testing 1 2 3")
      expect(@tactical.queue).to eq("routine")
    end

    it "should accept a delay: '10.seconds'" do
      @tactical.task(method: 'puts', args: 'Testing 1 2 3', delay: 10.seconds)
      expect_default
    end

    it "should accept routine: 'true' with interval: '1.day'" do
      pending "handle loops"
      @tactical.task(method: 'puts', args: 'Testing 1 2 3', interval: 1.day)
      expect_default
    end

    it "should accept repeat: '3' count" do
      @tactical.task(method: 'puts', args: 'Testing 1 2 3', repeat: 3)
      expect_default
    end

    it "should accept script_path: 'test.rb'" do
      @tactical.task(script: 'test.rb')
      expect(@tactical.method).to eq("Kernel.load")
      expect(@tactical.args).to match /test.rb/
      expect(@tactical.queue).to eq("default")
    end

    it "should accept a at a at: '01:30'", wip: true do
      pending "handle gem clockwork"
      @tactical.task(method: 'puts', args: 'Testing 1 2 3', at: '01:30')
      expect_default
    end
  end
end

### TESTS: feature ###
######################

############
### TODO ###
## == Timeout gem
#   require 'timeout'
#   status = Timeout::timeout(5) {
#     # Something that should be interrupted if it takes more than 5 seconds...
#   }

## == Clockwork gem
# :at parameter specifies when to trigger the event:
# Valid formats:
#   HH:MM
#    H:MM
#   **:MM
#   HH:**
#   (Mon|mon|Monday|monday) HH:MM
## SET as a background process
# clockwork script.rb &
### TODO ###
############
