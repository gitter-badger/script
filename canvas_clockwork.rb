#!/usr/bin/ruby -w
# canvas_clockwork.rb
# Author: Andy Bettisworth
# Description: Canvas Clockwork gem; a scheduling process

require 'clockwork'

## NOTE
## For convenience, create a link to clockwork binary
# ln ~/.rbenv/versions/2.1.0/bin/clockwork
# sudo ln -fs $HOME/.rbenv/versions/$RUBY_VERSION/bin/clockwork /usr/bin/clockwork;

#######################
### w/ gem Queue_Classic ###
require 'clockwork'
require 'queue_classic'
module Clockwork
  handler do |method|
    QC.enqueue(method)
  end

  every(10.seconds, "Kernel.puts")
  # every(10.seconds, "Kernel.puts", "hello world")
  # every(1.hour, "Kernel.puts", "hello world")
  # every(1.day, "Kernel.puts", "hello world", at: '01:30')
end
### w/ QueueClassic ###
#######################

##################
### QUICKSTART ###
## CREATE [clock.rb]
# require 'clockwork'
# module Clockwork
#   handler do |job|
#     puts "Running #{job}"
#   end

#   # handler receives the time when job is prepared to run in the 2nd argument
#   # handler do |job, time|
#   #   puts "Running #{job}, at #{time}"
#   # end

#   every(10.seconds, 'frequent.job')
#   every(3.minutes, 'less.frequent.job')
#   every(1.hour, 'hourly.job')

#   every(1.day, 'midnight.job', :at => '00:00')
# end

## EXEC
# clockwork clock.rb
### QUICKSTART ###
##################

#########################
### SETUP RUBYONRAILS ###
## UPDATE [Gemfile]
# gem 'clockwork', require: false

## CREATE [script/workers_schedule.rb]
# require 'clockwork'

## Require the full rails environment if needed
# require './config/boot'
# require './config/environment'

# include Clockwork

## Define the jobs
# handler do |job|
#   if job.eql?('frequent.cleanup_sessions')
#     Sessions.cleanup_expired()
#   elsif job.eql?('mondays.send_news')
#     NewsDispatcher.send_news_to_customers()
#   end
# end

## Define the schedule
# every(1.hour, 'frequent.cleanup_sessions')
# every(1.day, 'mondays.send_news', :at => '01:00', :if => lambda { |t| t.wday == 1 })

## TEST
# clockwork script/clockwork_jobs.rb
### SETUP RUBYONRAILS ###
#########################

## NOTE
# Use with queueing
# The clock process only makes sense as a place to schedule work to be done, not
# to do the work. It avoids locking by running as a single process, but this makes
# it impossible to parallelize. For doing the work, you should be using a job
# queueing system, such as Delayed Job, Beanstalk/Stalker, RabbitMQ/Minion, Resque,
# or Sidekiq. This design allows a simple clock process with no locks, but also
# offers near infinite horizontal scalability.

# Using a queueing system which doesn't require that your full application be loaded
# is preferable, because the clock process can keep a tiny memory footprint. If
# you're using DJ or Resque, however, you can go ahead and load your full application
# enviroment, and use per-event blocks to call DJ or Resque enqueue methods.
# For example, with DJ/Rails:

# Only one clock process should ever be running across your whole application
# deployment. For example, if your app is running on three VPS machines (two app
# servers and one database), your app machines might have the following process topography:
#     App server 1: 3 web (thin start), 3 workers (rake jobs:work), 1 clock (clockwork clock.rb)
#     App server 2: 3 web (thin start), 3 workers (rake jobs:work)
# You should use Monit, God, Upstart, or Inittab to keep your clock process running
# the same way you keep your web and workers running

########################
### Event Parameters ###
# :at parameter specifies when to trigger the event:
# Valid formats:
#   HH:MM
#    H:MM
#   **:MM
#   HH:**
#   (Mon|mon|Monday|monday) HH:MM
#
# The simplest example:
#   every(1.day, 'reminders.send', :at => '01:30')
# You can omit the leading 0 of the hour:
#   every(1.day, 'reminders.send', :at => '1:30')
# Wildcards for hour and minute are supported:
#   every(1.hour, 'reminders.send', :at => '**:30')
#   every(10.seconds, 'frequent.job', :at => '9:**')
# You can set more than one timing: send reminders at noon and evening
#   every(1.day, 'reminders.send', :at => ['12:00', '18:00'])
# You can specify the day of week to run:
#   every(1.week, 'myjob', :at => 'Monday 16:20')

# :tz parameter lets you specify a timezone (default is the local timezone):
# Runs the job each day at midnight, UTC.
# The value for :tz can be anything supported by [TZInfo](http://tzinfo.rubyforge.org/)
#   every(1.day, 'reminders.send', :at => '00:00', :tz => 'UTC')

# :if parameter is invoked every time the task is ready to run, and run if the return value is true.
# Run on every first day of month.
#   Clockwork.every(1.day, 'myjob', :if => lambda { |t| t.day == 1 })
# The argument is an instance of ActiveSupport::TimeWithZone if the :tz option is set. Otherwise, it's an instance of Time.
# This argument cannot be omitted. Please use _ as placeholder if not needed.
#   Clockwork.every(1.second, 'myjob', :if => lambda { |_| true })

# An event with :thread => true runs in a different thread.
# If a job is long-running or IO-intensive, this option helps keep the clock precise.
#   Clockwork.every(1.day, 'run.me.in.new.thread', :thread => true)
### Event Parameters ###
########################


#####################
### Configuration ###
# :logger
#   By default Clockwork logs to STDOUT. In case you prefer your own logger
#   implementation you have to specify the logger configuration option. See example below.
# :sleep_timeout
#   Clockwork wakes up once a second and performs its duties. To change the number
#   of seconds Clockwork sleeps, set the sleep_timeout configuration option as
#   shown below in the example.
# :tz
#   This is the default timezone to use for all events. When not specified this
#   defaults to the local timezone. Specifying :tz in the parameters for an event
#   overrides anything set here.
# :max_threads
#   Clockwork runs handlers in threads. If it exceeds max_threads, it will warn
#   you (log an error) about missing jobs.
# :thread
#   Boolean true or false. Default is false. If set to true, every event will be
#   run in its own thread. Can be overridden on a per event basis (see the :thread
#   option in the Event Parameters section above)
#
# Configuration example:
#   module Clockwork
#     configure do |config|
#       config[:sleep_timeout] = 5
#       config[:logger] = Logger.new(log_file_path)
#       config[:tz] = 'EST'
#       config[:max_threads] = 15
#       config[:thread] = true
#     end
#   end

# error_handler
# You can add error_handler to define your own logging or error rescue.
#
# module Clockwork
#   error_handler do |error|
#     Airbrake.notify_or_ignore(error)
#   end
# end

# Current specifications are as follows.
#   defining error_handler does not disable original logging
#   errors from error_handler itself are not rescued, and stop clockwork
### Configuration ###
#####################

###############################
### Anatomy of a Clock File ###
# clock.rb is standard Ruby.
# Since we include the Clockwork module (the clockwork binary does this automatically,
# or you can do it explicitly), this exposes a small DSL to define the handler
# for events, and then the events themselves.

# The handler typically looks like this:
#   handler { |job| enqueue_your_job(job) }
#
# This block will be invoked every time an event is triggered, with the job name
# passed in. In most cases, you should be able to pass the job name directly through
# to your queueing system.

# The second part of the file, which lists the events, roughly resembles a crontab:
#   every(5.minutes, 'thing.do')
#   every(1.hour, 'otherthing.do')
#
# An event will be triggered once every five minutes, passing the job name 'thing.do' into the handler.
# The handler shown above would thus call enqueue_your_job('thing.do').

# You can also pass a custom block to the handler, for job queueing systems that
# rely on classes rather than job names (i.e. DJ and Resque). In this case, you
# need not define a general event handler, and instead provide one with each event:
#   every(5.minutes, 'thing.do') { Thing.send_later(:do) }

## NOTE If you provide a custom handler for the block, the job name is used only for logging.

# You can also use blocks to do more complex checks:
#   every(1.day, 'check.leap.year') do
#     Stalker.enqueue('leap.year.party') if Date.leap?(Time.now.year)
#   end

# In addition, Clockwork also supports :before_tick and after_tick callbacks.
# They are optional, and run every tick (a tick being whatever your :sleep_timeout
# is set to, default is 1 second):
#   on(:before_tick) do
#     puts "tick"
#   end
#
#   on(:after_tick) do
#     puts "tock"
#   end
### Anatomy of a Clock File ###
###############################

############################
### Database Clockwork 1 ###
## CREATE model
# rails g model Job period:string name:string code:text

## Version 1

# require 'clockwork'
# require './config/boot'
# require './config/environment'

# module DBBackedClockwork
#   extend Clockwork

#   # add a periodic job to update @@events
#   # I think a thread is too complex

#   configure do |config|
#     config[:sleep_timeout] = 1
#     config[:tz] = 'Pacific Time (US & Canada)'
#     config[:max_threads] = 15
#   end

#   every 1.minute, "update jobs" do
#     db_events.each do |event|
#       event.update_from_db
#     end

#     # add database events
#     Job.all.each do |e|
#       events << DBBackedEvent.new(e) unless db_events.map(&:id).include?(e.id)
#     end
#   end

#   # get the manager object
#   def self.manager
#     Clockwork.class_variable_get(:@@manager)
#   end

#   # get the events array
#   def self.events
#     manager.instance_variable_get(:@events)
#   end

#   # get the db backed events from the events array
#   # NOTE: this creates a new array and is not associated to the "official" events instance variable
#   def self.db_events
#     events.reject{|e| !e.respond_to?(:id) }
#   end

#   class DBBackedEvent < Clockwork::Event
#     # add @id tagged to DB to update a job
#     attr_accessor :id, :updated_at

#     def initialize(event)
#       id = event.id
#       updated_at = event.updated_at
#       super(DBBackedClockwork.manager, eval(event.period), event.name, Proc.new {eval event.code})
#     end

#     # find the job in the database and update or remove it if necessary
#     def update_from_db
#       begin
#         job = Job.find(id)
#         if job.updated_at != updated_at
#           self.remove
#           DBBackedClockwork.events << DBBackedEvent.new(job)
#         end
#       rescue ActiveRecord::RecordNotFound
#         # remove the event
#         self.remove
#       end
#     end

#     # remove this event from the events array
#     def remove
#       DBBackedClockwork.events.reject!{|e| e.id == id rescue false}
#     end
#   end
# end
### Database Clockwork 1 ###
############################

############################
### Database Clockwork 2 ###
# Version 2
# This allows me to create jobs with an array of 'at times', version 1 would not

# require 'clockwork'
# require './config/boot'
# require './config/environment'

# module DBBackedClockwork
#   extend Clockwork

#   configure do |config|
#     config[:sleep_timeout] = 1
#     config[:tz] = 'America/Los_Angeles'
#     config[:max_threads] = 15
#   end

#   every 1.minute, "update db jobs" do

#     events.each do |event|
#       # if job has changed then delete event and reload it
#       if event.id
#         begin
#           job = Job.find(event.id)
#           if job.updated_at != event.updated_at
#             remove_event event
#             create_from_db job
#           end
#         rescue ActiveRecord::RecordNotFound
#           # remove job
#           remove_event event
#         end
#       end
#     end

#     # add database events
#     Job.all.each do |e|
#       unless events.map(&:id).include?(e.id)
#         create_from_db(e)
#       end
#     end
#   end

#   def self.remove_event(event)
#     puts "Removing #{event.job}..."
#     events.reject!{|e| e.id == event.id rescue false}
#   end

#   def self.create_from_db(event)
#     puts "Adding #{event.name}..."
#     options = Hash.new
#     options[:tz] = 'America/Los_Angeles'
#     options[:at] = event.at.split(',') if event.at
#     jobs = every eval("#{event.period}.#{event.period_type}"), event.name, options do
#       # do some work
#     end
#     jobs = [jobs] # ensure jobs is an array
#     jobs.flatten.each do |job|
#       job.id = event.id
#       job.updated_at = event.updated_at
#     end
#     jobs
#   end

#   # get the manager object
#   def self.manager
#     Clockwork.class_variable_get(:@@manager)
#   end

#   # get the events array
#   def self.events
#     manager.instance_variable_get(:@events)
#   end

#   class Clockwork::Event
#     attr_accessor :id, :updated_at
#   end

#   class Clockwork::Manager
#     def every_with_multiple_times(period, job, options={}, &block)
#       events = Array.new
#       each_options = options.clone
#       options[:at].each do |at|
#         each_options[:at] = at
#         events << register(period, job, block, each_options)
#       end
#       events
#     end
#   end
# end
### Database Clockwork 2 ###
############################
