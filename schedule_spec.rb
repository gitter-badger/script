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
    @delay  = params[:delay]
    @interval = params[:interval]
    execute
  end

  private

  def execute(delay = 0)
    timer = Timers.new
    if @delay
      timer.after(@delay) do
        enqueue_task(@method, @args)
        QC::Worker.new(q_name: @queue).work
      end
      timer.wait
    elsif @interval
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

#     it "should accept a at a specific_time: '01:30'" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', specific_time: '01:30')
#     end

#     it "should accept routine: 'true' with interval: '1.day'" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', interval: 1.day)
#     end

#     it "should accept repeat: '3' count" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', repeat: 3)
#     end

#     it "should accept script_path: 'background.rb'" do
#       tactical = Schedule.new
#       tactical.task(method: 'puts', args: 'Testing 1 2 3', script_path: 'background.rb')
#     end
#   end
# end


## IDEAS
## == Timeout gem
#   require 'timeout'
#   status = Timeout::timeout(5) {
#     # Something that should be interrupted if it takes more than 5 seconds...
#   }

## == Timers gem
# timer = Timers.new
# five_second_timer = timer.every(5) { puts "Take 5" }
# loop { timers.wait }
## ~OR~
# three_second_timer = timer.after(3) { puts "Take 3" }
# 3.times { timer.wait }

## == Clockwork gem
# :at parameter specifies when to trigger the event:
# Valid formats:
#   HH:MM
#    H:MM
#   **:MM
#   HH:**
#   (Mon|mon|Monday|monday) HH:MM
