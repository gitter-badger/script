#!/usr/bin/ruby -w
# time_trigger_spec.rb
# Author: Andy Bettisworth
# Description: Delayed/Scheduled script execution

require 'timers'
require 'chronic_duration'
require 'active_model'

class TimeTrigger
  include ActiveModel::Validations

  attr_accessor :script, :interval, :timer

  validates :script, presence: true
  validates :interval, presence: true

  def initialize(command, delay)
    delay_seconds = ChronicDuration::parse(delay)
    @script = command
    @interval = delay_seconds
    @timer = Timers.new
  end

  def trigger
    delayed_cmd = @timer.after(@interval) { @script.call }
    @timer.wait
  end

  def trigger_loop(*repeat_count)
    delayed_cmd = @timer.every(@interval) { @script.call }
    if repeat_count.size == 0
      loop { @timer.wait }
    elsif repeat_count.size == 1
      repeat_count[0].times { @timer.wait }
    end
  end
end
