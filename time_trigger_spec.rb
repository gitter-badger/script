#!/usr/bin/ruby -w
# time_trigger_spec.rb
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

describe TimeTrigger do
  let (:delay) { "3 seconds" }
  let (:command) { Proc.new {puts 'Testing 1 2 3'} }

  def init_clock(command, delay)
    TimeTrigger.new(command, delay)
  end

  describe '#trigger' do
    it "should execute target script after given delay" do
      clock = init_clock(command, delay)
      clock.trigger
    end
  end

  describe '#trigger_loop' do
    it "should execute recurring target script with given delay inbetween" do
      pending('It works. It also loops forever...')
      clock = init_clock(command, delay)
      clock.trigger_loop
    end

    it "should accept an iteration count" do
      clock = init_clock(command, delay)
      clock.trigger_loop(5)
    end
  end
end