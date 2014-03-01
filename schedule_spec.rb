#!/usr/bin/ruby -w
# schedule.rb
# Author: Andy Bettisworth
# Description: It schedules automated tasks

require 'optparse'
require 'queue_classic'
require 'timers'
require 'timeout'
require 'clockwork'

include Clockwork

class Schedule
  attr_accessor :queue

  def initialize(queue = 'default')
    self.queue = queue
  end

  def task(params)
    @method = params[:method]
    @args   = params[:args]
    if params[:script]
      @method = 'Kernel.load'
      @args   = ENV['HOME'] + '/.sync/.script/routine/' + params[:script]
    end
    @delay    = params[:delay]
    @interval = params[:interval]
    fail "Cannot have @interval and @delay" if @delay && @interval
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

# tactical = Schedule.new
# tactical.task(method: 'puts', args: 'Testing 1 2 3')
# tactical = Schedule.new('routine')
# tactical.task(method: 'puts', args: 'Testing 1 2 3')
# tactical = Schedule.new
# tactical.task(method: 'puts', args: 'Testing 1 2 3', delay: 10.seconds)
# tactical = Schedule.new
# tactical.task(method: 'puts', args: 'Testing 1 2 3', interval: 10.seconds)
# tactical = Schedule.new
# tactical.task(method: 'puts', args: 'Testing 1 2 3', repeat: 3)
# tactical = Schedule.new
# tactical.task(script: 'test.rb')

# describe Schedule do
#   describe "#schedule" do
#     it "should accept method: 'puts' and args: 'Testing 1 2 3' job input" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3')
#     end

#     it "should accept custom queue: 'routine'" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', queue: 'routine')
#     end

#     it "should accept a delay: '10.seconds'" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', delay: 10.seconds)
#     end

#     it "should accept routine: 'true' with interval: '1.day'" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', interval: 1.day)
#     end

#     it "should accept repeat: '3' count" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', repeat: 3)
#     end

#     it "should accept script_path: 'test.rb'" do
#       tactical = Schedule.new
#       tactical.task(script: 'test.rb')
#     end

#     it "should accept a at a at: '01:30'", wip: true do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', at: '01:30')
#     end
#   end
# end

## EXEC ruby file
# QC::Queue.new('routine').enqueue("Kernel.load", "/home/wurde/test.rb")
# QC::Worker.new(q_name: 'routine').start

## IDEAS
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
